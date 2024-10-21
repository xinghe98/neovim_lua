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
