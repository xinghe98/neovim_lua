---@diagnostic disable-next-line: undefined-global
-- 基本配
require('options')
-- 键盘映射
require('keymap')
-- 插件
require('plugins')
--markdown快捷键
require('markdown')
-- 主题设置
require('theme')
-- neovide
require('guiConfig')

vim.g.coc_global_extensions={
	 'coc-css',
	 'coc-sumneko-lua',
	 'coc-pairs',
	 'coc-go',
	 'coc-diagnostic',
	 'coc-docker',
	 'coc-eslint',
	 'coc-flutter-tools',
	 'coc-gitignore',
	 'coc-git',
	 'coc-html',
	 'coc-import-cost',
	 'coc-jest',
	 'coc-json',
	 'coc-lists',
	 'coc-omnisharp',
	 'coc-prettier',
	 'coc-prisma',
	 'coc-pyright',
	 'coc-snippets',
	 'coc-sourcekit',
	 'coc-stylelint',
	 'coc-syntax',
	 'coc-tasks',
	 'coc-tsserver',
	 -- 'coc-vetur',
	 '@yaegassy/coc-volar',
	 '@yaegassy/coc-volar-tools',
	 'coc-vimlsp',
	 'coc-yaml',
	 'coc-tabnine',
	 'coc-yank'
}
