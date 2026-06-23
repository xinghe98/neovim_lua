return {
  -- "zbirenbaum/copilot.lua",
  -- cmd = "Copilot",
  -- event = "InsertEnter",
  -- config = function()
  --   require("copilot").setup({
  --     suggestion = {
  --       enabled = true,
  --       auto_trigger = true, -- 自动触发建议
  --       keymap = {
  --         accept = "<C-q>", -- 接受建议
  --         accept_word = false,
  --         accept_line = false,
  --         next = "<C-n>",
  --         prev = "<C-p>",
  --       },
  --     },
  --     panel = { enabled = false }, -- 如果不需要面板可以关闭
  --   })
  -- end,
  {
    "milanglacier/minuet-ai.nvim",
    config = function()
      require("minuet").setup({
        provider = "openai_fim_compatible",
        provider_options = {
          openai_fim_compatible = {
            api_key = "DEEPSEEK_KEY",
            name = "DeepSeek",
            end_point = "https://api.deepseek.com/beta/completions",
            model = "deepseek-chat",
            optional = {
              max_tokens = 256,
              top_p = 0.9,
            },
          },
        },
        virtualtext = {
          auto_trigger_ft = { "*" },
          keymap = {
            -- accept whole completion
            accept = "<c-a>",
            -- accept one line
            accept_line = false,
            -- accept n lines (prompts for number)
            -- e.g. "A-z 2 CR" will accept 2 lines
            accept_n_lines = false,
            next = "<C-n>",
            prev = "<C-p>",
          },
        },
      })
    end,
  },
}
