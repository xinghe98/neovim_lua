local M = {}

local TITLE = "AI Herdr"
local CHUNK_SIZE = 8192

local function notify(message, level)
  vim.schedule(function()
    vim.notify(message, level or vim.log.levels.ERROR, { title = TITLE })
  end)
end

local function configured_pane_id()
  local value = vim.g.omp_herdr_pane_id or vim.env.OMP_HERDR_PANE_ID
  if value == nil then
    return nil
  end
  value = vim.trim(tostring(value))
  return value ~= "" and value or nil
end

local function select_omp_pane(panes, current)
  local configured = configured_pane_id()
  if configured and configured == current.pane_id then
    return nil, "目标 agent pane 不能与当前 Neovim pane 相同"
  end

  local candidates = {}
  local cwd = vim.fs.normalize(vim.fn.getcwd())
  for _, pane in ipairs(panes) do
    if configured and pane.pane_id == configured then
      return configured
    end
    if
      pane.pane_id ~= current.pane_id
      and pane.workspace_id == current.workspace_id
      and (pane.agent == "omp" or pane.agent == "opencode")
    then
      local score = (pane.agent == "omp" and 4 or 0) + (pane.tab_id == current.tab_id and 2 or 0)
      local pane_cwd = pane.foreground_cwd or pane.cwd
      if type(pane_cwd) == "string" and vim.fs.normalize(pane_cwd) == cwd then
        score = score + 1
      end
      candidates[#candidates + 1] = { id = pane.pane_id, score = score }
    end
  end

  if configured then
    return nil, "目标 Herdr pane 不存在：" .. configured
  end
  table.sort(candidates, function(a, b)
    if a.score == b.score then
      return a.id < b.id
    end
    return a.score > b.score
  end)

  if #candidates == 0 then
    return nil, "当前 workspace 未找到 OMP / OpenCode pane；请启动 agent，或设置 vim.g.omp_herdr_pane_id / OMP_HERDR_PANE_ID"
  end
  if candidates[2] and candidates[2].score == candidates[1].score then
    local ids = vim.tbl_map(function(candidate)
      return candidate.id
    end, candidates)
    return nil, "发现多个同优先级 agent pane（" .. table.concat(ids, ", ") .. "）；请显式设置目标 pane id"
  end
  return candidates[1].id
end

local function run_herdr(args, callback)
  local command = { "herdr", "pane" }
  vim.list_extend(command, args)
  local ok, err = pcall(vim.system, command, { text = true }, function(result)
    vim.schedule(function()
      callback(result)
    end)
  end)
  if not ok then
    vim.schedule(function()
      callback({ code = -1, stderr = tostring(err) })
    end)
  end
end

local function resolve_context(callback)
  -- The headless sidebar belongs to a tab; its initial pane can be closed
  -- while the daemon survives. Picker-spawned daemons may have no pane env.
  if vim.env.HERDR_PLUGIN_ID == "chmarax.herdr-nvim" and vim.tbl_contains(vim.v.argv, "--headless") then
    local workspace, tab = vim.env.HERDR_WORKSPACE_ID, vim.env.HERDR_TAB_ID
    if not workspace or workspace == "" or not tab or tab == "" then
      callback(nil, "Herdr 侧边栏缺少 workspace/tab 上下文")
      return
    end
    callback({ workspace_id = workspace, tab_id = tab })
    return
  end
  if vim.env.HERDR_ENV ~= "1" or not vim.env.HERDR_PANE_ID or vim.env.HERDR_PANE_ID == "" then
    callback(nil, "当前 Neovim 不在 Herdr pane 中")
    return
  end
  -- Ordinary pane IDs can change when moved; ask Herdr for live context.
  run_herdr({ "current", "--current" }, function(result)
    if result.code ~= 0 then
      callback(nil, "读取当前 Herdr pane 失败：" .. (result.stderr or "unknown error"))
      return
    end
    local ok, response = pcall(vim.json.decode, result.stdout or "")
    local current = ok and type(response) == "table" and type(response.result) == "table" and response.result.pane
    if type(current) ~= "table" or not current.pane_id or not current.workspace_id then
      callback(nil, "无法解析当前 Herdr pane")
      return
    end
    callback(current)
  end)
end

local function next_chunk(text, offset)
  local last = math.min(offset + CHUNK_SIZE - 1, #text)
  if last < #text then
    while last >= offset do
      local next_byte = text:byte(last + 1)
      if not next_byte or next_byte < 0x80 or next_byte > 0xBF then
        break
      end
      last = last - 1
    end
  end
  return text:sub(offset, last), last + 1
end

local function paste_message(target, message, offset, done)
  offset = offset or 1
  if offset > #message then
    done()
    return
  end

  local chunk, next_offset = next_chunk(message, offset)
  -- send-text writes raw input: bracketed paste keeps newlines out of OMP's submit handler.
  -- Herdr treats "--" as literal text, so pass the payload directly.
  run_herdr({ "send-text", target, "\27[200~" .. chunk .. "\27[201~" }, function(result)
    if result.code ~= 0 then
      notify("发送到 " .. target .. " 失败：" .. (result.stderr or "unknown error"))
      done()
      return
    end
    paste_message(target, message, next_offset, done)
  end)
end

local pending_messages = {}
local sending = false

local function process_next()
  if sending or #pending_messages == 0 then
    return
  end

  sending = true
  local message = table.remove(pending_messages, 1)
  local function done()
    sending = false
    process_next()
  end

  resolve_context(function(current, err)
    if not current then
      notify(err)
      done()
      return
    end

    run_herdr({ "list" }, function(list_result)
      if list_result.code ~= 0 then
        notify("读取 Herdr pane 列表失败：" .. (list_result.stderr or "unknown error"))
        done()
        return
      end
      local parsed, listing = pcall(vim.json.decode, list_result.stdout or "")
      local panes = parsed and type(listing) == "table" and type(listing.result) == "table" and listing.result.panes
      if type(panes) ~= "table" then
        notify("无法解析 Herdr pane 列表")
        done()
        return
      end

      local target, err = select_omp_pane(panes, current)
      if not target then
        notify(err)
        done()
        return
      end
      paste_message(target, message, nil, done)
    end)
  end)
end

local function send(message)
  if vim.fn.executable("herdr") ~= 1 then
    notify("未找到 herdr 命令，请检查 PATH")
    return
  end
  if message == nil or message == "" then
    notify("没有可发送的内容", vim.log.levels.WARN)
    return
  end

  pending_messages[#pending_messages + 1] = message
  process_next()
end

local function file_reference()
  local name = vim.api.nvim_buf_get_name(0)
  if name == "" or vim.fn.filereadable(name) ~= 1 then
    return nil
  end

  name = vim.fs.normalize(name)
  local relative = vim.fs.relpath(vim.fs.normalize(vim.fn.getcwd()), name)
  if relative and relative ~= "" and relative ~= "." then
    name = relative
  end
  return "@" .. name
end

local function visual_mode()
  local mode = vim.fn.mode()
  if mode == "v" or mode == "V" or mode == "\22" then
    return mode
  end
end

local function visual_positions()
  local mode = visual_mode()
  if not mode then
    return nil
  end

  local from = vim.fn.getpos("v")
  local to = vim.fn.getpos(".")
  if from[2] > to[2] or (from[2] == to[2] and from[3] > to[3]) then
    from, to = to, from
  end
  return from, to, mode
end

local function leave_visual_mode()
  vim.api.nvim_feedkeys(vim.keycode("<Esc>"), "nx", false)
end

function M.send_selection()
  local from, to, mode = visual_positions()
  if not from then
    notify("请先选择要发送的内容", vim.log.levels.WARN)
    return
  end

  local lines = vim.fn.getregion(from, to, { type = mode })
  leave_visual_mode()
  send(table.concat(lines, "\n"))
end

function M.send_position()
  local reference = file_reference()
  if not reference then
    notify("当前 buffer 不是已保存的文件", vim.log.levels.WARN)
    return
  end

  local from, to, mode = visual_positions()
  if from then
    leave_visual_mode()
    if mode == "V" then
      if from[2] == to[2] then
        send(("%s :L%d"):format(reference, from[2]))
      else
        send(("%s :L%d-L%d"):format(reference, from[2], to[2]))
      end
    elseif from[2] == to[2] then
      send(("%s :L%d:C%d-C%d"):format(reference, from[2], from[3], to[3]))
    else
      send(("%s :L%d:C%d-L%d:C%d"):format(reference, from[2], from[3], to[2], to[3]))
    end
    return
  end

  local cursor = vim.api.nvim_win_get_cursor(0)
  send(("%s :L%d:C%d"):format(reference, cursor[1], cursor[2] + 1))
end

function M.send_file()
  local reference = file_reference()
  if not reference then
    notify("当前 buffer 不是已保存的文件", vim.log.levels.WARN)
    return
  end
  send(reference)
end

return M
