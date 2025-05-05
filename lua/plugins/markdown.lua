return {
  "iamcco/markdown-preview.nvim",
  ft = "markdown",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = "cd app && yarn install",
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
  end,
  dependencies = {
    { "dhruvasagar/vim-table-mode" },
    { "mzlogin/vim-markdown-toc" },
    { "godlygeek/tabular" },
  },
}
