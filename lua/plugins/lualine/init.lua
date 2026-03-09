local theme = require("plugins.lualine.themes")
local sections = require("plugins.lualine.sections")

return {
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        theme                = theme.get_theme(),
        globalstatus         = true,
        component_separators = "",
        section_separators   = { left = "", right = "" },
        disabled_filetypes   = { statusline = { "dashboard", "alpha", "starter", "snacks_dashboard" } },
        always_divide_middle = true,
        padding              = { left = 1, right = 1 },
      },
      sections          = sections.sections,
      inactive_sections = sections.inactive_sections,
      tabline           = {},
      extensions        = { "lazy", "nvim-tree", "trouble", "quickfix" },
    },
  },
}
