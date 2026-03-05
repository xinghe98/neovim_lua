-- Lualine config with switchable themes
-- Theme 1: Bubbles (original)
-- Theme 2: Powerline (inspired by CodeCompanion screenshot)
--
-- 切换主题：修改下方 ACTIVE_THEME 变量
-- "bubbles"   → 圆角气泡风格
-- "powerline"  → 实心箭头 Powerline 风格

local ACTIVE_THEME = "powerline" -- ← 修改这里切换主题

-- stylua: ignore
local colors = {
	blue   = '#80a0ff',
	cyan   = '#79dac8',
	black  = '#080808',
	white  = '#c6c6c6',
	red    = '#ff5189',
	violet = '#FF7F24',
	grey   = '#303030',
	green  = '#a9b665',
	dark   = '#1e1e2e',
	dimgrey = '#45475a',
	yellow = '#e0af68',
	teal   = '#1abc9c',
}

-- ===== Theme: Bubbles =====
local bubbles_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.violet },
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.black, bg = "" },
  },
  insert = { a = { fg = colors.black, bg = colors.blue } },
  visual = { a = { fg = colors.black, bg = colors.cyan } },
  replace = { a = { fg = colors.black, bg = colors.red } },
  inactive = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.black, bg = colors.black },
  },
}

-- ===== Theme: Powerline =====
local powerline_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.green, gui = "bold" },
    b = { fg = colors.white, bg = colors.dimgrey },
    c = { fg = colors.white, bg = colors.dark },
  },
  insert = {
    a = { fg = colors.black, bg = colors.blue, gui = "bold" },
    b = { fg = colors.white, bg = colors.dimgrey },
    c = { fg = colors.white, bg = colors.dark },
  },
  visual = {
    a = { fg = colors.black, bg = colors.violet, gui = "bold" },
    b = { fg = colors.white, bg = colors.dimgrey },
    c = { fg = colors.white, bg = colors.dark },
  },
  replace = {
    a = { fg = colors.black, bg = colors.red, gui = "bold" },
    b = { fg = colors.white, bg = colors.dimgrey },
    c = { fg = colors.white, bg = colors.dark },
  },
  command = {
    a = { fg = colors.black, bg = colors.yellow, gui = "bold" },
    b = { fg = colors.white, bg = colors.dimgrey },
    c = { fg = colors.white, bg = colors.dark },
  },
  inactive = {
    a = { fg = colors.dimgrey, bg = colors.dark },
    b = { fg = colors.dimgrey, bg = colors.dark },
    c = { fg = colors.dimgrey, bg = colors.dark },
  },
}

-- ===== 共享组件 =====

local comp_lsp = {
  function()
    local msg = "No Active Lsp"
    local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
      return msg
    end
    local servername = {}
    for k, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        servername[k] = client.name
      end
    end
    return table.concat(servername, ", ")
  end,
  icon = " LSP:",
  color = { fg = "#ffffff", gui = "bold" },
}

local comp_snippet = {
  function()
    local luasnip = require("luasnip")
    if luasnip.expand_or_jumpable() then
      return "snippetting 😉"
    end
    return ""
  end,
}

local comp_codeium = {
  function()
    local ok, vt = pcall(function()
      return require("codeium.virtual_text").status()
    end)
    if not ok then
      return ""
    end
    local status = vt
    if status.state == "idle" then
      return "🐣"
    end
    if status.state == "waiting" then
      return "🐥"
    end
    if status.state == "completions" and status.total > 0 then
      return string.format("🐥 %d/%d", status.current, status.total)
    end
    return "⛔️"
  end,
}

local comp_flutter = {
  function()
    local ok, dec = pcall(function()
      return vim.g.flutter_tools_decorations.device
    end)
    if ok and dec then
      return dec
    end
    return ""
  end,
}

local comp_diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  symbols = { error = " ", warn = " ", info = " " },
  diagnostics_color = {
    color_error = { fg = colors.red },
    color_warn = { fg = colors.yellow },
    color_info = { fg = colors.cyan },
  },
}

local comp_diff = {
  "diff",
  symbols = { added = " ", modified = " ", removed = " " },
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.yellow },
    removed = { fg = colors.red },
  },
}

local comp_ai_model = {
  function()
    local ok, ms = pcall(require, "plugins.codecompanion.model_selector")
    if not ok then
      return ""
    end
    local adapter = ms.active_adapter
    local model = ms.current[adapter] or "?"
    local short = model:match("[^/]+$") or model
    return adapter .. "(" .. short .. ")"
  end,
  icon = "🤖",
  color = {  gui = "bold" },
}

local comp_spinner = require("codecompanion._extensions.spinner.styles.lualine").get_lualine_component()

-- ===== 布局配置 =====

local function bubbles_sections()
  return {
    lualine_a = {
      { "mode", separator = { left = "" }, right_padding = 2 },
    },
    lualine_b = {
      "filename",
      comp_lsp,
      comp_snippet,
      comp_codeium,
      comp_flutter,
      comp_diagnostics,
    },
    lualine_c = {},
    lualine_x = { comp_diff },
    lualine_y = {
      comp_spinner,
      comp_ai_model,
      "branch",
      "filetype",
      "progress",
    },
    lualine_z = {
      { "location", separator = { right = "" }, left_padding = 2 },
    },
  }
end

local function powerline_sections()
  return {
    lualine_a = {
      { "mode" },
    },
    lualine_b = {
      { "branch", icon = "" },
      "filename",
    },
    lualine_c = {
      comp_lsp,
      comp_snippet,
      comp_diagnostics,
    },
    lualine_x = {
      comp_diff,
      comp_codeium,
      comp_flutter,
    },
    lualine_y = {
      comp_spinner,
      comp_ai_model,
      "filetype",
    },
    lualine_z = {
      "progress",
      { "location" },
    },
  }
end

-- ===== 构建最终配置 =====
local theme_map = {
  bubbles = {
    lualine_theme = bubbles_theme,
    sections = bubbles_sections,
    separators = { left = "", right = "" },
    component_separators = "|",
  },
  powerline = {
    lualine_theme = powerline_theme,
    sections = powerline_sections,
    separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
  },
}

return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function()
      local t = theme_map[ACTIVE_THEME] or theme_map.powerline

      return {
        options = {
          theme = t.lualine_theme,
          globalstatus = true,
          component_separators = t.component_separators,
          section_separators = t.separators,
        },
        sections = t.sections(),
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        extensions = { "lazy", "nvim-tree" },
      }
    end,
  },
}
