local colors = require("plugins.lualine.colors")

local M = {}

-- Mode names mapping
local mode_names = {
  ["n"] = "NORMAL",
  ["no"] = "O-PENDING",
  ["nov"] = "O-PENDING",
  ["noV"] = "O-PENDING",
  ["no\16"] = "O-PENDING",
  ["niI"] = "NORMAL",
  ["niR"] = "NORMAL",
  ["niV"] = "NORMAL",
  ["nt"] = "NORMAL",
  ["v"] = "VISUAL",
  ["vs"] = "VISUAL",
  ["V"] = "V-LINE",
  ["Vs"] = "V-LINE",
  ["\16"] = "V-BLOCK",
  ["\16s"] = "V-BLOCK",
  ["s"] = "SELECT",
  ["S"] = "S-LINE",
  ["\19"] = "S-BLOCK",
  ["i"] = "INSERT",
  ["ic"] = "INSERT",
  ["ix"] = "INSERT",
  ["R"] = "REPLACE",
  ["Rc"] = "REPLACE",
  ["Rx"] = "REPLACE",
  ["Rv"] = "V-REPLACE",
  ["c"] = "COMMAND",
  ["cv"] = "COMMAND",
  ["ce"] = "COMMAND",
  ["r"] = "REPLACE",
  ["rm"] = "MORE",
  ["r?"] = "CONFIRM",
  ["!"] = "SHELL",
  ["t"] = "TERMINAL",
}

-- Mode colors
local mode_colors = {
  ["NORMAL"] = colors.mode.normal,
  ["O-PENDING"] = colors.mode.normal,
  ["INSERT"] = colors.mode.insert,
  ["VISUAL"] = colors.mode.visual,
  ["V-LINE"] = colors.mode.visual,
  ["V-BLOCK"] = colors.mode.visual,
  ["SELECT"] = colors.mode.visual,
  ["S-LINE"] = colors.mode.visual,
  ["S-BLOCK"] = colors.mode.visual,
  ["REPLACE"] = colors.mode.replace,
  ["V-REPLACE"] = colors.mode.replace,
  ["COMMAND"] = colors.mode.command,
  ["SHELL"] = colors.mode.command,
  ["TERMINAL"] = colors.mode.terminal,
  ["MORE"] = colors.mode.command,
  ["CONFIRM"] = colors.mode.command,
}

-- Get current mode color
function M.get_mode_color()
  local mode = mode_names[vim.fn.mode()] or "NORMAL"
  return mode_colors[mode] or colors.mode.normal
end

-- Mode icons
local mode_icons = {
  ["NORMAL"] = "󰰓",
  ["O-PENDING"] = "󰰓",
  ["INSERT"] = "󰰶",
  ["VISUAL"] = "󰰬",
  ["V-LINE"] = "󰰬",
  ["V-BLOCK"] = "󰰬",
  ["SELECT"] = "󰰬",
  ["S-LINE"] = "󰰬",
  ["S-BLOCK"] = "󰰬",
  ["REPLACE"] = "󰰶",
  ["V-REPLACE"] = "󰰶",
  ["COMMAND"] = "󰰙",
  ["SHELL"] = "󰰙",
  ["TERMINAL"] = "󰰙",
  ["MORE"] = "󰰙",
  ["CONFIRM"] = "󰰙",
}

-- Mode component with dynamic color
M.mode = {
  function()
    local mode = mode_names[vim.fn.mode()] or "NORMAL"
    local icon = mode_icons[mode] or ""
    return icon .. " " .. mode
  end,
  color = function()
    return { fg = M.get_mode_color(), gui = "bold" }
  end,
  padding = { left = 1, right = 1 },
}

-- LSP client component
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

    -- Truncate long names
    local display = table.concat(names, ", ")
    if #display > 20 then
      display = display:sub(1, 17) .. "..."
    end
    return display
  end,
  -- icon = "",
  color = { fg = colors.cyan },
  cond = function()
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    return #clients > 0
  end,
}

-- AI model selector component
M.ai_model = (function()
  local ok, ms = pcall(require, "cc_model_selector")
  if ok and ms.get_lualine_component then
    return ms.get_lualine_component()
  end
  return {
    function()
      return ""
    end,
  }
end)()

-- Branch component
M.branch = {
  "branch",
  icon = "",
  color = { fg = colors.pink },
  padding = { left = 0, right = 1 },
}

-- Diff component
M.diff = {
  "diff",
  symbols = {
    added = "󰸋 ",
    modified = "󰛿 ",
    removed = "󰍷 ",
  },
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.yellow },
    removed = { fg = colors.red },
  },
  color = { bg = colors.grey },
}

-- Diagnostics component
M.diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  symbols = {
    error = "󰅙 ",
    warn = "󰀦 ",
    info = "󰋼 ",
    hint = "󰌶",
  },
  diagnostics_color = {
    error = { fg = colors.red },
    warn = { fg = colors.yellow },
    info = { fg = colors.blue },
    hint = { fg = colors.teal },
  },
  update_in_insert = false,
}

-- Filetype component
M.filetype = {
  "filetype",
  icon_only = true,
  padding = { left = 1, right = 0 },
}

-- Filesize component
M.filesize = {
  function()
    local size = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))
    if size < 1024 then
      return string.format(" %dB", size)
    elseif size < 1024 * 1024 then
      return string.format(" %.1fK", size / 1024)
    else
      return string.format(" %.1fM", size / (1024 * 1024))
    end
  end,
  color = { fg = colors.surface_alt },
  cond = function()
    return vim.fn.getfsize(vim.api.nvim_buf_get_name(0)) > 0
  end,
}

-- Progress component
M.progress = {
  "progress",
  icon = "󰝖",
  color = { fg = colors.white },
}

-- CodeCompanion spinner component
M.spinner = require("codecompanion._extensions.spinner.styles.lualine").get_lualine_component()

-- Codeium component (optional)
M.codeium = {
  function()
    local ok, vt = pcall(function()
      return require("codeium.virtual_text").status()
    end)
    if not ok then
      return ""
    end
    local status = vt
    if status.state == "idle" then
      return " "
    end
    if status.state == "waiting" then
      return " "
    end
    if status.state == "completions" and status.total > 0 then
      return string.format(" %d/%d", status.current, status.total)
    end
    return ""
  end,
  color = { fg = colors.teal },
  cond = function()
    return pcall(require, "codeium.virtual_text")
  end,
}

return M
