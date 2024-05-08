--[[

██╗  ██╗██╗███╗   ██╗ ██████╗     ██╗  ██╗███████╗
╚██╗██╔╝██║████╗  ██║██╔════╝     ██║  ██║██╔════╝
 ╚███╔╝ ██║██╔██╗ ██║██║  ███╗    ███████║█████╗
 ██╔██╗ ██║██║╚██╗██║██║   ██║    ██╔══██║██╔══╝
██╔╝ ██╗██║██║ ╚████║╚██████╔╝    ██║  ██║███████╗
╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝     ╚═╝  ╚═╝╚══════╝

 ]]
require("plugins")
-- 基本设置
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
	"coc-highlight",
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
	-- "coc-syntax",
	"coc-word",
	"coc-emoji",
	"coc-tasks",
	"coc-tsserver",
	"@yaegassy/coc-volar",
	"coc-emmet",
	"@yaegassy/coc-volar-tools",
	"coc-vimlsp",
	"coc-yaml",
	"coc-yank",
	"coc-symbol-line"
}
