local M = {}

local input_toggle = false
local en = "1033"
local zh = "2052"

local function system(args)
  return vim.trim(vim.fn.system(args))
end

function M.to_en(opts)
  opts = opts or {}

  if vim.fn.has("win32") == 1 then
    local status = system({ "im-select.exe" })
    if status ~= en then
      if opts.remember ~= false then
        input_toggle = true
      end
      system({ "im-select.exe", en })
    end
    return
  end

  local status = tonumber(system("fcitx5-remote"))
  if status == 2 then
    if opts.remember ~= false then
      input_toggle = true
    end
    system("fcitx5-remote -c")
  end
end

function M.to_zh(opts)
  opts = opts or {}
  if not opts.force and not input_toggle then
    return
  end

  if vim.fn.has("win32") == 1 then
    system({ "im-select.exe", zh })
  else
    system("fcitx5-remote -o")
  end
  input_toggle = false
end

function M.setup()
  vim.opt.ttimeoutlen = 100

  local group = vim.api.nvim_create_augroup("input_method_switch", { clear = true })

  vim.api.nvim_create_autocmd("InsertLeave", {
    group = group,
    callback = function()
      M.to_en()
    end,
  })

  vim.api.nvim_create_autocmd("InsertEnter", {
    group = group,
    callback = function()
      M.to_zh()
    end,
  })
end

return M
