return {
  -- 模型选择器扩展（与 spinner 同级配置）
  model_selector = {
    opts = {
      default_adapter = "copilot",
      adapters = {
        copilot = {
          base = "copilot",
          default = "GPT-5.3-Codex",
          choices = {
            "GPT-5.3-Codex",
          },
        },
        openrouter = {
          base = "openai_compatible",
          env = {
            url = "https://openrouter.ai/api/v1",
            api_key = "cmd:echo $OPENROUTER_KEY",
            chat_url = "/chat/completions",
          },
          default = "z-ai/glm-5.1",
          choices = {
            "minimax/minimax-m2.7",
            "z-ai/glm-5.1",
            "moonshotai/kimi-k2.5",
            "qwen/qwen3-coder-next",
          },
        },
        zai = {
          base = "openai_compatible",
          env = {
            url = "https://api.z.ai/api/coding/paas/v4",
            api_key = "cmd:echo $ZAI_KEY",
            chat_url = "/chat/completions",
          },
          default = "glm-5.1",
          choices = {
            "glm-5.1",
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
