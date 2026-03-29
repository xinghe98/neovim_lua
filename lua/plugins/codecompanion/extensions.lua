return {
  -- 模型选择器扩展（与 spinner 同级配置）
  model_selector = {
    opts = {
      default_adapter = "openrouter",
      adapters = {
        openrouter = {
          base = "openai_compatible",
          env = {
            url = "https://openrouter.ai/api/v1",
            api_key = "cmd:echo $OPENROUTER_KEY",
            chat_url = "/chat/completions",
          },
          default = "minimax/minimax-m2.7",
          choices = {
            "minimax/minimax-m2.7",
            "z-ai/glm-5",
            "moonshotai/kimi-k2.5",
            "qwen/qwen3-coder-next",
          },
        },

        ucloud = {
          base = "openai_compatible",
          env = {
            url = "https://api.modelverse.cn/v1",
            api_key = "cmd:echo $UCLOUD_KEY",
            chat_url = "/chat/completions",
          },
          default = "zai-org/glm-5",
          choices = {
            "zai-org/glm-5",
            "gpt-5.3-codex",
            "MiniMax-M2.5",
            "Qwen/Qwen3-Coder",
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
