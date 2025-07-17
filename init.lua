-- bootstrap lazy.nvim, LazyVim and your plugins
if vim.g.vscode then
  -- VSCode Neovim
  require("config.vscode")
else
  -- 普通 Neovim
  require("config.lazy")
  require("config.customhighlight")
  require("config.markdown")
  require("config.neovide")
end
