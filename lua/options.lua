local set = vim.opt
set.number=true
set.rnu=true
set.wrap=false
set.fileformat=unix
set.cindent=true
set.tabstop=4
set.shiftwidth=4
set.showmatch=true
set.scrolloff=5
set.laststatus=2
set.fenc='utf-8'
vim.g.mapleader=" "
set.matchtime=5
set.ignorecase=true
set.incsearch=true
set.hlsearch=true
set.expandtab=false
set.autoread=true
vim.g.t_Co=256
--vim.opt.termguicolors = true
vim.cmd('colorscheme gruvbox-material')
vim.opt.completeopt = {'noinsert','menuone','noselect','preview'}
vim.cmd([[
let g:coc_global_extensions = [
	\ 'coc-css',
	\ 'coc-diagnostic',
	\ 'coc-docker',
	\ 'coc-eslint',
	\ 'coc-explorer',
	\ 'coc-flutter-tools',
	\ 'coc-gitignore',
	\ 'coc-git',
	\ 'coc-html',
	\ 'coc-import-cost',
	\ 'coc-jest',
	\ 'coc-json',
	\ 'coc-lists',
	\ 'coc-omnisharp',
	\ 'coc-prettier',
	\ 'coc-prisma',
	\ 'coc-pyright',
	\ 'coc-snippets',
	\ 'coc-sourcekit',
	\ 'coc-stylelint',
	\ 'coc-syntax',
	\ 'coc-tasks',
	\ 'coc-tsserver',
	\ 'coc-vetur',
	\ 'coc-vimlsp',
	\ 'coc-yaml',
	\ 'coc-yank']
]])
