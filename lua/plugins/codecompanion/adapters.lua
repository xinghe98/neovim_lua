local ms = require("cc_model_selector")

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
            default = ms.get_current_model("openrouter"),
            choices = ms.config.models.openrouter and ms.config.models.openrouter.choices or {},
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
            default = ms.get_current_model("deepseek"),
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
            default = ms.get_current_model("yunwu"),
            choices = ms.config.models.yunwu and ms.config.models.yunwu.choices or {},
          },
          temperature = {
            default = 0.0,
          },
        },
      })
    end,
  },
}
