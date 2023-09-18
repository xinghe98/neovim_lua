--[[

██╗  ██╗██╗███╗   ██╗ ██████╗     ██╗  ██╗███████╗
╚██╗██╔╝██║████╗  ██║██╔════╝     ██║  ██║██╔════╝
 ╚███╔╝ ██║██╔██╗ ██║██║  ███╗    ███████║█████╗  
 ██╔██╗ ██║██║╚██╗██║██║   ██║    ██╔══██║██╔══╝  
██╔╝ ██╗██║██║ ╚████║╚██████╔╝    ██║  ██║███████╗
╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝     ╚═╝  ╚═╝╚══════╝

 ]]
-- 插件
require("plugins")
-- require("nvim-treesitter.install").prefer_git = true
-- 基本配
require("options")
-- 键盘映射
require("keymap")
-- 主题设置
require("theme")
--markdown快捷键
require("markdown")
-- neovide
require("guiConfig")
-- 美化相关
require("style")
vim.g.coc_global_extensions = {
	"coc-css",
	"coc-sumneko-lua",
	"coc-go",
	"coc-diagnostic",
	"coc-docker",
	"coc-eslint",
	"coc-flutter-tools",
	"coc-gitignore",
	"coc-git",
	"coc-html",
	"coc-jest",
	"coc-json",
	"coc-lists",
	"coc-omnisharp",
	"coc-prettier",
	"coc-prisma",
	"coc-snippets",
	"coc-sourcekit",
	"coc-syntax",
	"coc-tasks",
	"coc-tsserver",
	"@yaegassy/coc-volar",
	"@yaegassy/coc-volar-tools",
	"coc-vimlsp",
	"coc-yaml",
	"coc-yank",
}
