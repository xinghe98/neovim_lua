return {
  -- LSP keymaps
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- change a keymap
      keys[#keys + 1] = { "gh", ":Lspsaga hover_doc<CR>" }
      keys[#keys + 1] = { "gd", ":Telescope lsp_definitions theme=dropdown<CR>" }
      keys[#keys + 1] = { "gr", ":Telescope lsp_references theme=dropdown<CR>" }
      keys[#keys + 1] = { "<leader>g", ":Telescope diagnostics theme=dropdown<CR>" }
      keys[#keys + 1] = { "<M-a>", ":Lspsaga code_action<CR>" }
      keys[#keys + 1] = { "<leader>rn", ":Lspsaga rename<CR>" }
      keys[#keys + 1] = { "g[", ":Lspsaga hover_doc<CR>" }
      keys[#keys + 1] = { "g]", ":Lspsaga diagnostic_jump_prev<CR>" }
      keys[#keys + 1] = { "<leader>e", ":Lspsaga show_line_diagnostics<CR>" }
      -- -- disable a keymap
      -- keys[#keys + 1] = { "K", false }
      -- add a keymap
      keys[#keys + 1] = { "H", "<cmd>echo 'hello'<cr>" }
    end,
  },
}
