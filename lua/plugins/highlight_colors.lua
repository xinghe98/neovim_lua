return {
  {
    "brenoprata10/nvim-highlight-colors",
    event = "VimEnter",
    config = function()
      require("nvim-highlight-colors").setup({})
    end,
  },
}
