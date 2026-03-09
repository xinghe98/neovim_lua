local colors = require("plugins.lualine.colors")
local components = require("plugins.lualine.components")

local M = {}

-- Separator icons
local sep = {
  left = { "", "" }, -- Powerline left separator
  right = { "'", "'" }, -- Powerline right separator
  block = { "", "" }, -- No separator
  space = { " ", " " }, -- Space separator
}

-- Helper: create colored component
local function hl(comp, opts)
  opts = opts or {}
  local c = type(comp) == "string" and { comp } or vim.deepcopy(comp)
  if opts.color then
    c.color = opts.color
  end
  if opts.cond then
    c.cond = opts.cond
  end
  if opts.padding then
    c.padding = opts.padding
  end
  if opts.separator then
    c.separator = opts.separator
  end
  return c
end

-- Active sections
M.sections = {
  lualine_a = {
    hl(components.mode, { separator = sep.left }),
  },

  lualine_b = {
    hl(components.branch, { separator = sep.left }),
    hl(components.diff, { separator = sep.left }),
  },

  lualine_c = {
    hl(components.diagnostics, { separator = sep.space }),
  },

  lualine_x = {
    hl(components.spinner, { separator = sep.space, color = { fg = colors.yellow } }),
    hl(components.ai_model, { separator = sep.space }),
    hl(components.codeium, { separator = sep.space }),
  },

  lualine_y = {
    hl(components.filetype, { separator = sep.right }),
    hl(components.lsp, { separator = sep.right }),
  },

  lualine_z = {
    hl(components.progress, { separator = sep.right }),
  },
}

-- Inactive sections (minimal)
M.inactive_sections = {
  lualine_a = {},
  lualine_b = {},
  lualine_c = {
    {
      "filename",
      path = 1, -- Relative path
      symbols = { modified = "●", readonly = " ", unnamed = "[No Name]" },
      color = { fg = colors.surface_alt },
    },
  },
  lualine_x = {
    -- { "location", color = { fg = colors.surface_alt } },
  },
  lualine_y = {},
  lualine_z = {},
}

return M
