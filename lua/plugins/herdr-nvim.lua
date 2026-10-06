-- herdr-nvim（ChmaraX/herdr-nvim）nvim 侧：代码批注，发送给 herdr 内的 agent。
-- herdr 侧（侧边栏 + 文件 picker）由 `herdr plugin install ChmaraX/herdr-nvim` 安装，
-- 键位在 ~/.config/herdr/config.toml（prefix+v 侧边栏 / prefix+p 选文件）。
-- 与 config/omp_herdr.lua（发选区/位置/文件给 OMP pane）互补，键位不冲突：
--   <leader>ac 批注当前行/选区   <leader>al 批注列表
--   <leader>as 发送批注（不提交） <leader>aS 发送批注并提交
--   <leader>ai 插入 path:行号 引用
return {
  "ChmaraX/herdr-nvim",
  -- Load before the sidebar daemon's VimEnter setup; lazy.nvim owns the maps.
  lazy = false,
  keys = {
    { "<leader>ac", ":Herdr comment<CR>", mode = { "n", "x" }, desc = "Herdr 批注当前行/选区" },
    { "<leader>al", "<cmd>Herdr list<CR>", desc = "Herdr 批注列表" },
    { "<leader>as", "<cmd>Herdr send<CR>", desc = "Herdr 粘贴批注" },
    { "<leader>aS", "<cmd>Herdr submit<CR>", desc = "Herdr 提交批注" },
    { "<leader>ai", ":Herdr ref<CR>", mode = { "n", "x" }, desc = "Herdr 插入代码引用" },
  },
  opts = {
    prefix = "<leader>a",
    keymaps = false,
    clear_after_send = true,
  },
}
