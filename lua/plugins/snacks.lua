return {
  {
    "folke/snacks.nvim",
    opts = {
      scope = {
        enabled = false,
      },
      explorer = { enabled = false },
      indent = {
        enabled = true,
        chunk = {
          -- when enabled, scopes will be rendered as chunks, except for the
          -- top-level scope which will be rendered as a scope.
          enabled = true,
          -- only show chunk scopes in the current window
          only_current = false,
          priority = 200,
          hl = "SnacksIndentChunk", ---@type string|string[] hl group for chunk scopes
          char = {
            -- corner_top = "┌",
            -- corner_bottom = "└",
            corner_top = "┏", -- 粗左上角 (U+250F)
            corner_bottom = "┗", -- 粗左下角 (U+2517)
            horizontal = "━", -- 粗横线 (U+2501)
            vertical = "┃", -- 粗竖线 (U+2503)
            arrow = "➞",
            -- corner_top = "╭",
            -- corner_bottom = "╰",
            -- horizontal = "─",
            -- vertical = "│",
            -- arrow = ">",
          },
        },
      },
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
        {
          "<leader>w",
          function()
            -- 1. 获取光标下的单词
            local word = vim.fn.expand("<cword>")

            -- 2. 调用 snacks.nvim 的 lines picker
            -- 使用 pattern 选项来设置初始的搜索查询
            require("snacks").picker.lines({ pattern = word })
          end,
          desc = "查找当前单词",
        },
      }
    end, -- Top Pickers & Explorer
  },
  { "HiPhish/rainbow-delimiters.nvim" },
}
