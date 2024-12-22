return {
  -- add gruvbox
  {
    "sainnhe/gruvbox-material",
    config = function()
      vim.g.gruvbox_material_enable_italic = true
      vim.g.gruvbox_material_transparent_background = 1
      vim.g.gruvbox_material_current_word = "underline"
      -- 设置补全菜单透明背景
    end,
  },
  -- add onedarkpro
  {
    "olimorris/onedarkpro.nvim",
    opts = {
      styles = {
        comments = "bold",
        properties = "bold",
        functions = "bold",
        keywords = "italic",
        operators = "bold",
        conditionals = "italic",
        loops = "italic",
        booleans = "bold,italic",
      },
      options = {
        cursorline = false, -- Use cursorline highlighting?
        transparency = true, -- Use a transparent background?
        terminal_colors = true, -- Use the theme's colors for Neovim's :terminal?
        lualine_transparency = false, -- Center bar transparency?
        highlight_inactive_windows = false, -- When the window is out of focus, change the normal background?
      },
    },
  },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "onedark",
      colorscheme = "gruvbox-material",
    },
  },
}
