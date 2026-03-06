return {
  -- 模型选择器扩展（与 spinner 同级配置）
  model_selector = {
    opts = {
      default_adapter = "yunwu",
      models = {
        openrouter = {
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
          default = "claude-sonnet-4-6",
          choices = {
            "claude-sonnet-4-6",
            "claude-opus-4-6-thinking",
            "gemini-3-pro-preview",
          },
        },
        deepseek = {
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
