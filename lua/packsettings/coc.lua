local keymap = vim.api.nvim_set_keymap
vim.g.coc_global_extensions={
	 'coc-css',
	 'coc-diagnostic',
	 'coc-docker',
	 'coc-eslint',
	 'coc-explorer',
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
	 'coc-vetur',
	 'coc-vimlsp',
	 'coc-yaml',
	 'coc-yank'
}
vim.api.nvim_command("command! -nargs=? Fold :call CocAction('fold', <f-args>)")
vim.api.nvim_command("hi! link CocPum Pmenu")
keymap('n', '<leader>rn', '<Plug>(coc-rename)', {silent = true})
keymap( 'n', 'gd', '<Plug>(coc-definition)', {silent = true})
keymap( 'n', 'gy', '<Plug>(coc-type-definition)', {silent = true})
keymap( 'n', 'gi', '<Plug>(coc-implementation)', {silent = true})
keymap( 'n', 'gr', '<Plug>(coc-references)', {silent = true})
keymap( 'i', '<c-f>', "coc#pum#visible() ? '<c-y>' : '<c-f>'", {silent = true, expr = true})
keymap( 'i', '<TAB>', "coc#pum#visible() ? coc#pum#next(1) : col('.') == 1 || getline('.')[col('.') - 2] =~# '\\s' ? \"\\<TAB>\" : coc#refresh()", {silent = true, noremap = true, expr = true})
keymap( 'i', '<s-tab>', "coc#pum#visible() ? coc#pum#prev(1) : \"\\<s-tab>\"", {silent = true, noremap = true, expr = true})
keymap( 'i', '<cr>', "coc#pum#visible() ? coc#pum#confirm() : \"\\<c-g>u\\<cr>\\<c-r>=coc#on_enter()\\<cr>\"", {silent = true, noremap = true, expr = true})
keymap( 'i', '<c-y>', "coc#pum#visible() ? coc#pum#confirm() : '<c-y>'", {silent = true, noremap = true, expr = true})
keymap('n', '<leader>hp', ':call CocAction("doHover")<cr>', {silent = true} )
