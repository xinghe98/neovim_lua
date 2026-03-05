return {
  "nvim-treesitter/nvim-treesitter",
  opts = { ensure_installed = { "dart", "markdown", "markdown_inline", "tsx" } },
  lazy = false,
  build = ":TSUpdate",
}
