return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "lalitmee/codecompanion-spinners.nvim",
    "j-hui/fidget.nvim",
  },
  init = function()
    require("plugins.codecompanion.keymaps")
  end,
  opts = {
    extensions = require("plugins.codecompanion.extensions"),
    language = "zh-CN",
    strategies = require("plugins.codecompanion.strategies"),
    adapters = require("plugins.codecompanion.adapters"),
    prompt_library = require("plugins.codecompanion.prompts"),
  },
}
