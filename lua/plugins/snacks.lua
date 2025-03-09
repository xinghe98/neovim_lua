return {
  {
    "folke/snacks.nvim",
    opts = {
      scope = {
        enabled = false,
      },
      explorer = { enabled = false },
      indent = { enabled = true },
      input = { enabled = true },
      picker = {
        enabled = true,
        win = {
          input = {
            keys = {
              ["<Tab>"] = { "list_down", mode = { "i", "n" } },
              ["<S-Tab>"] = { "list_up", mode = { "i", "n" } },
              ["<c-e>"] = { "preview_scroll_down", mode = { "i", "n" } },
              ["<c-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
            },
          },
        },
      },
      notifier = { enabled = true },
      quickfile = { enabled = true },
    },
    keys = function()
      return {
        {
          "<leader>sm",
          function()
            Snacks.picker.smart()
          end,
          desc = "Smart Find Files",
        },
        {
          "<leader>fb",
          function()
            Snacks.picker.buffers()
          end,
          desc = "Buffers",
        },
        {
          "<C-g>",
          function()
            Snacks.picker.grep()
          end,
          desc = "Grep",
        },
        {
          "<C-f>",
          function()
            Snacks.picker.files()
          end,
          desc = "Find Files",
        },
        {
          "<leader>ft",
          function()
            Snacks.picker.todo_comments()
          end,
          desc = "Todo",
        },
      }
    end, -- Top Pickers & Explorer
  },
  { "HiPhish/rainbow-delimiters.nvim" },
}
