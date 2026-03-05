return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      suggestion = {
        enabled = true,
        auto_trigger = true, -- 自动触发建议
        keymap = {
          accept = "<C-q>", -- 接受建议
          accept_word = false,
          accept_line = false,
          next = "<C-n>",
          prev = "<C-p>",
        },
      },
      panel = { enabled = false }, -- 如果不需要面板可以关闭
    })
  end,
}
