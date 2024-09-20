vim.api.nvim_set_hl(0, "CocSymbolLineSeparator", { fg = "#82AAFF", bg = "NONE", bold = true })
vim.cmd([[
hi GitGutterAdd    ctermfg=106 guifg=#29B6F6
hi GitGutterChange ctermfg=136 guifg=#8BC34A
hi GitGutterDelete ctermfg=160 guifg=#EF5350
hi CocFloating ctermbg=6 guibg=(0,0,0,0)
hi CocSearch ctermfg=6 guifg=#BCEE68 gui=bold
hi CocInlayHint guifg=#696969 guibg=(0,0,0,0)
hi CocSymbolUnit  ctermfg=6 guifg=#EF9A9A
hi CocSymbolNumber ctermfg=5 guifg=#F48FB1
hi CocSymbolFunction ctermfg=6 guifg=#CE93D8
hi CocSymbolKey   ctermfg=223 guifg=#B39DDB
hi CocSymbolKeyword ctermfg=4 guifg=#EF5350
hi CocSymbolReference ctermfg=223 guifg=#C5CAE9
hi CocSymbolFolder ctermfg=6 guifg=#42A5F5
hi CocSymbolVariable ctermfg=223 guifg=#EF5350
hi CocSymbolNull  ctermfg=4 guifg=#E91E63
hi CocSymbolValue ctermfg=6 guifg=#4DD0E1
hi CocSymbolConstant ctermfg=223 guifg=#81C784
hi CocSymbolText  ctermfg=6 guifg=#C8E6C9
hi CocSymbolModule ctermfg=4 guifg=#29B6F6
hi CocSymbolPackage ctermfg=4 guifg=#AB47BC
hi CocSymbolClass ctermfg=223 guifg=#FFA726
hi CocSymbolOperator ctermfg=4 guifg=#F8BBD0
hi CocSymbolStruct ctermfg=4 guifg=#8BC34A
hi CocSymbolObject ctermfg=6 guifg=#26A69A
hi CocSymbolMethod ctermfg=6 guifg=#4DB6AC
hi CocSymbolArray ctermfg=6 guifg=#FF8F00
hi CocSymbolEnum  ctermfg=6 guifg=#FFB300
hi CocSymbolField ctermfg=223 guifg=#4FC3F7
hi CocSymbolInterface ctermfg=6 guifg=#B39DDB
hi CocSymbolProperty ctermfg=223 guifg=#E1BEE7
hi CocSymbolColor ctermfg=5 guifg=#FFEBEE
hi CocSymbolFile  ctermfg=4 guifg=#F3E5F5
hi CocSymbolEvent ctermfg=223 guifg=#FFF3E0
hi CocSymbolTypeParameter ctermfg=223 guifg=#26C6DA
hi CocSymbolConstructor ctermfg=223 guifg=#4DD0E1
hi CocSymbolSnippet ctermfg=6 guifg=#9575CD
hi CocSymbolBoolean ctermfg=4 guifg=#FFAB91
hi CocSymbolNamespace ctermfg=4 guifg=#FFAB91
hi CocSymbolString ctermfg=2 guifg=#F44336
hi CocSymbolEnumMember ctermfg=223 guifg=#AB47BC
]])
vim.api.nvim_command("command! -nargs=? Fold :call CocAction('fold', <f-args>)")
vim.api.nvim_command("hi! link CocPum Pmenu")
-- Utility functions shared between progress reports for LSP and DAP
-- Some servers have issues with backup files, see #649
vim.opt.backup = false
vim.opt.writebackup = false

-- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
-- delays and poor user experience
vim.opt.updatetime = 100

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appeared/became resolved
vim.opt.signcolumn = "yes"

local keyset = vim.keymap.set
-- Autocomplete
function _G.check_back_space()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
end

-- Use Tab for trigger completion with characters ahead and navigate
-- NOTE: There's always a completion item selected by default, you may want to enable
-- no select by setting `"suggest.noselect": true` in your configuration file
-- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
-- other plugins before putting this into your config

local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(0) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(0) : "\<C-h>"]], opts)

-- Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice
keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)
vim.g.coc_snippet_next = '<c-e>'

vim.g.coc_snippet_prev = '<c-u>'
-- Use <c-j> to trigger snippets
keyset("i", "<c-e>", "<Plug>(coc-snippets-expand-jump)")
-- Use <c-space> to trigger completion
keyset("i", "<A-a>", "coc#refresh()", { silent = true, expr = true })
-- Use `[g` and `]g` to navigate diagnostics
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
--[[ keyset("n", "ek", "<Plug>(coc-diagnostic-prev)", { silent = true })
keyset("n", "ej", "<Plug>(coc-diagnostic-next)", { silent = true }) ]]
keyset("n", "ge", "<cmd>Telescope coc diagnostics<CR>", { silent = true })

-- GoTo code navigation
keyset("n", "gd", "<Plug>(coc-definition)", { silent = true })
keyset("n", "gy", "<Plug>(coc-type-definition)", { silent = true })
keyset("n", "gi", "<cmd>Telescope coc implementations<CR>", { silent = true })
keyset("n", "gr", "<cmd>Telescope coc references<CR>", { silent = true })
keyset("n", "<C-c>", "<cmd>Telescope coc commands<CR>", { silent = true })
keyset("n", "gh", ':call CocAction("doHover")<cr>', { silent = true })
keyset("n", "<leader>e", '<Plug>(coc-diagnostic-info)', { silent = true })
keyset("n", "<leader>ff", "<cmd>CocList --auto-preview files<cr>", { silent = true })
keyset("n", "<leader>gg", "<cmd>CocList grep<cr>", { silent = true })
keyset("n", "<leader>w", "<cmd>exe 'CocList -I --normal --auto-preview --input='.expand('<cword>').' words'<CR>",
	{ silent = true })
keyset("n", "<C-'>", "<cmd>CocList marks<cr>", { silent = true })
-- Highlight the symbol and its references on a CursorHold event(cursor is idle)
vim.api.nvim_create_augroup("CocGroup", {})
vim.api.nvim_create_autocmd("CursorHold", {
	group = "CocGroup",
	command = "silent call CocActionAsync('highlight')",
	desc = "Highlight symbol under cursor on CursorHold",
})

-- Symbol renaming
keyset("n", "<leader>rn", "<Plug>(coc-rename)", { silent = true })

-- Formatting selected code
keyset("x", "<leader>f", "<Plug>(coc-format-selected)", { silent = true })
keyset("n", "<leader>f", "<Plug>(coc-format-selected)", { silent = true })

-- Setup formatexpr specified filetype(s)
vim.api.nvim_create_autocmd("FileType", {
	group = "CocGroup",
	pattern = "typescript,json",
	command = "setl formatexpr=CocAction('formatSelected')",
	desc = "Setup formatexpr specified filetype(s).",
})

-- Update signature help on jump placeholder
vim.api.nvim_create_autocmd("User", {
	group = "CocGroup",
	pattern = "CocJumpPlaceholder",
	command = "call CocActionAsync('showSignatureHelp')",
	desc = "Update signature help on jump placeholder",
})

-- Apply codeAction to the selected region
-- Example: `<leader>aap` for current paragraph
local opts = { silent = true, nowait = true }
keyset("x", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)
keyset("n", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)

-- Remap keys for apply code actions at the cursor position.
keyset("n", "<M-A>", "<Plug>(coc-codeaction-cursor)", opts)
-- Remap keys for apply code actions affect whole buffer.
keyset("n", "<M-S>", "<Plug>(coc-codeaction-source)", opts)
-- Remap keys for applying codeActions to the current buffer
keyset("n", "<M-a>", "<Plug>(coc-codeaction)", opts)
-- Apply the most preferred quickfix action on the current line.
keyset("n", "<C-a>", "<Plug>(coc-fix-current)", opts)

-- Remap keys for apply refactor code actions.
keyset("n", "<leader>re", "<Plug>(coc-codeaction-refactor)", { silent = true })
keyset("x", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
keyset("n", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })

-- Run the Code Lens actions on the current line
keyset("n", "<leader>cl", "<Plug>(coc-codelens-action)", opts)

-- Map function and class text objects
-- NOTE: Requires 'textDocument.documentSymbol' support from the language server
keyset("x", "if", "<Plug>(coc-funcobj-i)", opts)
keyset("o", "if", "<Plug>(coc-funcobj-i)", opts)
keyset("x", "af", "<Plug>(coc-funcobj-a)", opts)
keyset("o", "af", "<Plug>(coc-funcobj-a)", opts)
keyset("x", "ic", "<Plug>(coc-classobj-i)", opts)
keyset("o", "ic", "<Plug>(coc-classobj-i)", opts)
keyset("x", "ac", "<Plug>(coc-classobj-a)", opts)
keyset("o", "ac", "<Plug>(coc-classobj-a)", opts)

-- Remap <C-f> and <C-b> to scroll float windows/popups
---@diagnostic disable-next-line: redefined-local
local opts = { silent = true, nowait = true, expr = true }
keyset("i", "<C-e>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-e>"', opts)
keyset("n", "<C-e>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-e>"', opts)
keyset("i", "<C-u>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-u>"', opts)
keyset("n", "<C-u>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-u>"', opts)
-- Use CTRL-S for selections ranges
-- Requires 'textDocument/selectionRange' support of language server
--[[ keyset("n", "<C-s>", "<Plug>(coc-range-select)", { silent = true })
keyset("x", "<C-s>", "<Plug>(coc-range-select)", { silent = true }) ]]

-- Add `:Format` command to format current buffer
vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})

-- " Add `:Fold` command to fold current buffer
vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", { nargs = "?" })

-- Add `:OR` command for organize imports of the current buffer
vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

-- Add (Neo)Vim's native statusline support
-- NOTE: Please see `:h coc-status` for integrations with external plugins that
-- provide custom statusline: lightline.vim, vim-airline
vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")

function _G.symbol_line()
	local curwin = vim.g.statusline_winid or 0
	local curbuf = vim.api.nvim_win_get_buf(curwin)
	local ok, line = pcall(vim.api.nvim_buf_get_var, curbuf, 'coc_symbol_line')
	return ok and line or ''
end

vim.o.winbar = '%!v:lua.symbol_line()'
