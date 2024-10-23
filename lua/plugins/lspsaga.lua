return {
  {
    "nvimdev/lspsaga.nvim",
    -- after = "nvim-lspconfig",
    event = "LspAttach",
    init = function()
      require("lspsaga").setup({
        ui = {
          code_action = "",
        },
        scroll_preview = {
          scroll_down = "<C-e>",
          scroll_up = "<C-u>",
        },
        code_action = {
          show_server_name = true,
          keys = {
            quit = "<esc>",
            exec = "<CR>",
          },
        },
        rename = {
          keys = {
            quit = "<esc>",
          },
        },
      })
    end,
  },
}
