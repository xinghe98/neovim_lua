local M = {}

function M.config()
    vim.g.coc_global_extensions = {
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
    vim.api.nvim_command("hi! link CocMenuSel PmenuSel")
	local G = {}
	function G.map(maps)
    for _,map in pairs(maps) do
        vim.api.nvim_set_keymap(map[1], map[2], map[3], map[4])
    end
end
    G.map({
        { 'n', '<leader>rn', '<Plug>(coc-rename)', {silent = true} },
        { 'n', 'gd', '<Plug>(coc-definition)', {silent = true} },
        { 'n', 'gy', '<Plug>(coc-type-definition)', {silent = true} },
        { 'n', 'gi', '<Plug>(coc-implementation)', {silent = true} },
        { 'n', 'gr', '<Plug>(coc-references)', {silent = true} },
        { 'n', 'K', ':call CocAction("doHover")<cr>', {silent = true} },
        { 'i', '<c-f>', "coc#pum#visible() ? '<c-y>' : '<c-f>'", {silent = true, expr = true} },
        { 'i', '<TAB>', "coc#pum#visible() ? coc#pum#next(1) : col('.') == 1 || getline('.')[col('.') - 2] =~# '\\s' ? \"\\<TAB>\" : coc#refresh()", {silent = true, noremap = true, expr = true} },
        { 'i', '<s-tab>', "coc#pum#visible() ? coc#pum#prev(1) : \"\\<s-tab>\"", {silent = true, noremap = true, expr = true} },
        { 'i', '<cr>', "coc#pum#visible() ? coc#pum#confirm() : \"\\<c-g>u\\<cr>\\<c-r>=coc#on_enter()\\<cr>\"", {silent = true, noremap = true, expr = true} },
        { 'i', '<c-y>', "coc#pum#visible() ? coc#pum#confirm() : '<c-y>'", {silent = true, noremap = true, expr = true} },
    })
end

function M.setup()
    -- do nothing
end

return M
