local keymap = vim.api.nvim_set_keymap
local opts ={noremap= true,silent=true}
keymap('','H' ,'^',opts)
keymap('','L', '$',opts)
keymap('n','<leader>l', '<C-w>l',opts)
keymap('n','<leader>k', '<C-w>k',opts)
keymap('n','<leader>h', '<C-w>h',opts)
keymap('n','<leader>j', '<C-w>j',opts)
keymap('n','<S-Tab>', '<<',opts)
keymap('n','<Tab>', '>>',opts)
keymap('v','<S-Tab>', '<',opts)
keymap('v','<Tab>', '>',opts)
keymap('', '<S-j>', '5j',opts)
keymap('', 'K', '5k',opts)
keymap('n', 'qq', ':nohlsearch<CR>',opts)
keymap('n', '<leader><leader>', ':bn<CR>',opts)
keymap('n', '<leader><backspace>', ':bp<CR>',opts)
keymap('n', '<c-w>', ':NvimTreeFindFileToggle<CR> :bd<CR> :NvimTreeFindFileToggle<CR> <C-w>l',opts)
keymap('n', '<S-s>', ':w<CR>',opts)
keymap('n', '<S-q>', ':q<CR>',opts)
keymap('i', '<C-a>', '<Home>',opts)
keymap('i','<C-e>', '<End>',opts)
keymap('n','<leader><leader>p', ':set paste<CR>',opts)
keymap('n', '<leader>np', ':set nopaste<CR>',opts)
keymap('n', 'r', ':call CompileRunGcc()<CR>',opts)
keymap('n', '<leader>t', ':TranslateW<CR>',opts)
keymap('v', '<leader>t', ':TranslateW<CR>',opts)
keymap('','<C-c>','"+y',opts)
keymap('n','<C-t>',':FloatermToggle<CR>',opts)
keymap('t','<C-t>','<C-\\><C-n>:FloatermToggle<CR>',opts)
-- coc-exporler
keymap('n', 'tt', ':NvimTreeFindFileToggle<CR>',opts)
vim.cmd([[func! CompileRunGcc()
	exec "w"
	if &filetype == 'python'
		:FloatermNew --autoclose=0 python3 %
	elseif &filetype == 'html'
		silent! exec "!".g:mkdp_browser." % &"
	elseif &filetype == 'markdown'
		exec "MarkdownPreview"
		exec "TableModeEnable"
	elseif &filetype == 'javascript'
		:FloatermNew --autoclose=0 export DEBUG="INFO,ERROR,WARNING"; node --trace-warnings .
	elseif &filetype == 'go'
		:FloatermNew --autoclose=0 go run .
	elseif &filetype == 'typescript'
		:FloatermNew --autoclose=0 export DEBUG="INFO,ERROR,WARNING"; ts-node %
	endif
endfunc]])
