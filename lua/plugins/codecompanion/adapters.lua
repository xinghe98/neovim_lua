return {
  http = {
    openrouter = function()
      return require("codecompanion.adapters").extend("openai_compatible", {
        env = {
          url = "https://openrouter.ai/api/v1",
          api_key = "cmd:echo $openrouter",
          chat_url = "/chat/completions",
        },
        schema = {
          model = {
            default = "minimax/minimax-m2.5",
            choices = {
              "claude-3.5-sonnet",
              "claude-3.7-sonnet",
              "claude-3.7-sonnet-thought",
              "gpt-4o-2024-08-06",
              "gemini-2.0-flash-001",
            },
          },
          temperature = {
            default = 0.0,
          },
        },
      })
    end,

    deepseek = function()
      return require("codecompanion.adapters").extend("deepseek", {
        env = {
          api_key = "cmd:echo $DEEPSEEK_KEY",
        },
        schema = {
          model = {
            -- 🔴 关键：Inline 模式绝对不要用 deepseek-reasoner (R1)
            default = "deepseek-chat",
          },
          temperature = {
            default = 0.0,
          },
        },
      })
    end,

    yunwu = function()
      return require("codecompanion.adapters").extend("openai_compatible", {
        env = {
          url = "https://yunwu.ai",
          api_key = "cmd:echo $YUNWU_KEY",
          chat_url = "/v1/chat/completions",
        },
        schema = {
          model = {
            default = "claude-sonnet-4-6",
            choices = {
              "claude-opus-4-6-thinking",
              "gemini-3-pro-preview",
            },
          },
          temperature = {
            default = 0.0,
          },
        },
      })
    end,
  },
}
