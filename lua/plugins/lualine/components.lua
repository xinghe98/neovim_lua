local colors = require("plugins.lualine.colors")

local M = {}

--------------------------------------------------------------------------------
-- Native LSP Name Component
--------------------------------------------------------------------------------

M.lsp = {
  function()
    local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    if #clients == 0 then
      return ""
    end

    local names = {}
    for _, client in ipairs(clients) do
      local filetypes = client.config and client.config.filetypes or {}
      if vim.tbl_contains(filetypes, buf_ft) or #filetypes == 0 then
        table.insert(names, client.name)
      end
    end

    if #names == 0 then
      return ""
    end

    local display = table.concat(names, ", ")
    if #display > 20 then
      display = display:sub(1, 17) .. "..."
    end
    return display
  end,
  -- icon = "",
  icon = vim.fn.nr2char(0x2699) .. " ",
  color = { fg = colors.black, gui = "bold" },
  separator = {
    left = vim.fn.nr2char(0xE0BA),
    right = vim.fn.nr2char(0xE0BC),
  },
  cond = function()
    return #vim.lsp.get_clients({ bufnr = 0 }) > 0
  end,
}

--------------------------------------------------------------------------------
-- Flutter Device Component
--------------------------------------------------------------------------------

M.flutter_device = {
  function()
    local decorations = vim.g.flutter_tools_decorations
    if decorations and decorations.device and decorations.device ~= "" then
      return decorations.device
    end
    return ""
  end,
  icon = "",
  cond = function()
    local decorations = vim.g.flutter_tools_decorations
    return decorations ~= nil and decorations.device ~= nil and decorations.device ~= ""
  end,
}

--------------------------------------------------------------------------------
-- Codeium Component
--------------------------------------------------------------------------------

M.codeium = {
  function()
    local ok, vt = pcall(require, "codeium.virtual_text")
    if not ok then
      return ""
    end
    local status = vt.status()
    if status.state == "waiting" then
      return "󰔟 …"
    elseif status.state == "completions" and status.total > 0 then
      return string.format("󰚩 %d/%d", status.current, status.total)
    else
      return "󰚩"
    end
  end,
  color = function()
    local ok, vt = pcall(require, "codeium.virtual_text")
    if not ok then
      return {}
    end
    local state = vt.status().state
    if state == "completions" then
      return { fg = colors.cyan, gui = "bold" }
    elseif state == "waiting" then
      return { fg = colors.violet }
    end
    return {}
  end,
}

--------------------------------------------------------------------------------
-- AI Model Component
--------------------------------------------------------------------------------

local ok_ms, ms = pcall(require, "cc_model_selector")
M.ai_model = ok_ms and ms.get_lualine_component({
  icon = "🤖",
  color = { fg = colors.green, gui = "bold" },
}) or {
  function()
    return ""
  end,
  cond = function()
    return false
  end,
}

--------------------------------------------------------------------------------
-- CodeCompanion Spinner Component
--------------------------------------------------------------------------------

M.spinner = require("codecompanion._extensions.spinner.styles.lualine").get_lualine_component()

--------------------------------------------------------------------------------
-- Spacer Component (transparent gap)
--------------------------------------------------------------------------------

M.spacer = {
  function()
    return " "
  end,
  padding = 0,
  color = { fg = "NONE", bg = "NONE" },
}

return M
