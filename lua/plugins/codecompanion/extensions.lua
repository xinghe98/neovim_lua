return {
  -- 模型选择器扩展（与 spinner 同级配置）
  model_selector = {
    opts = {
      default_adapter = "yunwu",
      adapters = {
        openrouter = {
          base = "openai_compatible",
          env = {
            url = "https://openrouter.ai/api/v1",
            api_key = "cmd:echo $openrouter",
            chat_url = "/chat/completions",
          },
          default = "minimax/minimax-m2.5",
          choices = {
            "minimax/minimax-m2.5",
            "claude-3.5-sonnet",
            "claude-3.7-sonnet",
            "claude-3.7-sonnet-thought",
            "gpt-4o-2024-08-06",
            "gemini-2.0-flash-001",
          },
        },
        yunwu = {
          base = "openai_compatible",
          env = {
            url = "https://yunwu.ai",
            api_key = "cmd:echo $YUNWU_KEY",
            chat_url = "/v1/chat/completions",
          },
          default = "claude-sonnet-4-6",
          choices = {
            "claude-sonnet-4-6",
            "claude-opus-4-6-thinking",
            "gemini-3-pro-preview",
          },
        },
        deepseek = {
          base = "deepseek",
          env = {
            api_key = "cmd:echo $DEEPSEEK_KEY",
          },
          default = "deepseek-chat",
          choices = {
            "deepseek-chat",
            "deepseek-reasoner",
          },
        },
      },
    },
  },

  -- Spinner 扩展
  spinner = {
    opts = {
      style = "fidget",
      ["cursor-relative"] = {
        text = "",
        hl_positions = {
          { 0, 3 },
          { 3, 6 },
          { 6, 9 },
        },
        interval = 100,
        hl_group = "Title",
        hl_dim_group = "NonText",
      },
    },
  },
}
