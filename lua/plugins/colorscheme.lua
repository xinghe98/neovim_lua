return {
  -- add gruvbox
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
      colorscheme = "onedark",
    },
  },
}
