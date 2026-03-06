local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- 切换 AI 对话窗口
keymap("n", "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", opts)
-- 针对选中文本输入 AI 指令
keymap("v", "<leader>aa", ":CodeCompanion ", { noremap = true, silent = false })
keymap("v", "<leader>ad", ":CodeCompanionChat Add<cr> ", { noremap = true, silent = false })
keymap("v", "<leader>ao", ":CodeCompanionChat<cr> ", { noremap = true, silent = false })
-- 打开 AI 操作面板
keymap("n", "<leader>ac", "<cmd>CodeCompanionActions<cr>", opts)
-- 生成中文 Git 提交信息
vim.keymap.set("n", "<leader>am", function()
  vim.cmd("CodeCompanion Commit Message (CN)")
end, { desc = "AI 生成中文 Commit Message" })
-- 切换 AI 模型
vim.keymap.set("n", "<leader>as", function()
  require("cc_model_selector").select_adapter_and_model()
end, { desc = "切换 AI 模型" })
