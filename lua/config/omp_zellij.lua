local M = {}

local TITLE = "OMP Zellij"
local CHUNK_SIZE = 8192

local function notify(message, level)
  vim.schedule(function()
    vim.notify(message, level or vim.log.levels.ERROR, { title = TITLE })
  end)
end

local function pane_id(id)
  if id == nil then
    return nil
  end

  local value = tostring(id):match("^%s*(.-)%s*$")
  if value == "" then
    return nil
  end

  return value:match("^terminal_") and value or "terminal_" .. value
end

local function current_pane_id()
  return pane_id(vim.env.ZELLIJ_PANE_ID)
end

local function configured_pane_id()
  return pane_id(vim.g.omp_zellij_pane_id or vim.env.OMP_ZELLIJ_PANE_ID)
end

local function is_omp_pane(pane)
  if pane.is_plugin or pane.exited then
    return false
  end

  local command = pane.pane_command or ""
  local executable = command:match('^"([^"]+)"') or command:match("^([^%s]+)") or ""
  local basename = executable:gsub("\\", "/"):match("([^/]+)$"):lower()
  if basename == "omp" or basename == "omp.exe" then
    return true
  end

  local title = (pane.title or ""):lower()
  return title:match("^omp[%s:]") ~= nil or title:match("^π%s*:") ~= nil
end

local function select_omp_pane(panes)
  local configured = configured_pane_id()
  local current = current_pane_id()

  if configured then
    if configured == current then
      return nil, "OMP pane 不能与当前 Neovim pane 相同"
    end
    return configured
  end

  local current_tab
  local cwd = vim.fs.normalize(vim.fn.getcwd())
  for _, pane in ipairs(panes) do
    if pane_id(pane.id) == current then
      current_tab = pane.tab_id
      break
    end
  end

  local candidates = {}
  for _, pane in ipairs(panes) do
    local id = pane_id(pane.id)
    if id ~= current and is_omp_pane(pane) then
      local score = 0
      if current_tab ~= nil and pane.tab_id == current_tab then
        score = score + 2
      end
      if pane.pane_cwd and vim.fs.normalize(pane.pane_cwd) == cwd then
        score = score + 1
      end
      candidates[#candidates + 1] = { pane = pane, id = id, score = score }
    end
  end

  table.sort(candidates, function(a, b)
    if a.score == b.score then
      return tostring(a.id) < tostring(b.id)
    end
    return a.score > b.score
  end)

  if #candidates == 0 then
    return nil, "未找到 OMP pane；请启动 omp，或设置 vim.g.omp_zellij_pane_id / OMP_ZELLIJ_PANE_ID"
  end

  if candidates[2] and candidates[2].score == candidates[1].score then
    local ids = vim.tbl_map(function(candidate)
      return candidate.id
    end, candidates)
    return nil, "发现多个 OMP pane（" .. table.concat(ids, ", ") .. "）；请显式设置目标 pane id"
  end

  return candidates[1].id
end

local function run_zellij(args, callback)
  local command = { "zellij", "action" }
  vim.list_extend(command, args)
  vim.system(command, { text = true }, function(result)
    vim.schedule(function()
      callback(result)
    end)
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
  run_zellij({ "paste", "--pane-id", target, "--", chunk }, function(result)
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

  run_zellij({ "list-panes", "--json", "--command", "--state", "--tab" }, function(result)
    if result.code ~= 0 then
      notify("读取 Zellij pane 失败：" .. (result.stderr or "unknown error"))
      done()
      return
    end

    local ok, panes = pcall(vim.json.decode, result.stdout or "")
    if not ok or type(panes) ~= "table" then
      notify("无法解析 Zellij pane 列表")
      done()
      return
    end

    local target, err = select_omp_pane(panes)
    if not target then
      notify(err)
      done()
      return
    end
    paste_message(target, message, nil, done)
  end)
end

local function send(message)
  if not vim.env.ZELLIJ then
    notify("当前 Neovim 不在 Zellij 会话中")
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
