vim.api.nvim_set_hl(0, "CocSymbolLineSeparator", { fg = "#82AAFF", bg = "NONE", bold = true })
vim.cmd([[
hi CocSearch ctermfg=6 guifg=#FFA726
hi CocInlayHint guifg=#696969 guibg=(0,0,0,0)
hi CocSymbolUnit  ctermfg=6 guifg=#EF9A9A
hi CocSymbolNumber ctermfg=5 guifg=#F48FB1
hi CocSymbolFunction ctermfg=6 guifg=#CE93D8
hi CocSymbolKey   ctermfg=223 guifg=#B39DDB
hi CocSymbolKeyword ctermfg=4 guifg=#EF5350
hi CocSymbolReference ctermfg=223 guifg=#C5CAE9
hi CocSymbolFolder ctermfg=6 guifg=#42A5F5
hi CocSymbolVariable ctermfg=223 guifg=#4FC3F7
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
vim.g.coc_snippet_next = '<c-j>'

vim.g.coc_snippet_prev = '<c-k>'
-- Use <c-j> to trigger snippets
keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")
-- Use <c-space> to trigger completion
keyset("i", "<A-a>", "coc#refresh()", { silent = true, expr = true })
-- Use `[g` and `]g` to navigate diagnostics
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
keyset("n", "ek", "<Plug>(coc-diagnostic-prev)", { silent = true })
keyset("n", "ej", "<Plug>(coc-diagnostic-next)", { silent = true })
keyset("n", "ge", "<cmd>Telescope coc diagnostics<CR>", { silent = true })

-- GoTo code navigation
keyset("n", "gd", "<Plug>(coc-definition)", { silent = true })
keyset("n", "gy", "<Plug>(coc-type-definition)", { silent = true })
keyset("n", "gi", "<cmd>Telescope coc implementations<CR>", { silent = true })
keyset("n", "gr", "<cmd>Telescope coc references<CR>", { silent = true })
keyset("n", "gh", ':call CocAction("doHover")<cr>', { silent = true })
keyset("n", "<leader>e", '<Plug>(coc-diagnostic-info)', { silent = true })
keyset("n", "<S-f>", "<cmd>CocList --auto-preview files<cr>", { silent = true })
keyset("n", "<C-d>", "<cmd>CocList grep<cr>", { silent = true })
keyset("n", "<leader>w", "<cmd>exe 'CocList -I --normal --auto-preview --input='.expand('<cword>').' words'<CR>",
	{ silent = true })
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
keyset("n", "<leader>ac", "<Plug>(coc-codeaction-cursor)", opts)
-- Remap keys for apply code actions affect whole buffer.
keyset("n", "<leader>as", "<Plug>(coc-codeaction-source)", opts)
-- Remap keys for applying codeActions to the current buffer
keyset("n", "<A-a>", "<Plug>(coc-codeaction)", opts)
-- Apply the most preferred quickfix action on the current line.
keyset("n", "<A-f>", "<Plug>(coc-fix-current)", opts)

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
keyset("i", "<C-n>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-n>"', opts)
keyset("i", "<C-u>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-u>"', opts)

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
--[[ local client_notifs = {}

local function get_notif_data(client_id, token)
 if not client_notifs[client_id] then
   client_notifs[client_id] = {}
 end

 if not client_notifs[client_id][token] then
   client_notifs[client_id][token] = {}
 end

 return client_notifs[client_id][token]
end


local spinner_frames = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" }

local function update_spinner(client_id, token)
 local notif_data = get_notif_data(client_id, token)

 if notif_data.spinner then
   local new_spinner = (notif_data.spinner + 1) % #spinner_frames
   notif_data.spinner = new_spinner

   notif_data.notification = vim.notify(nil, nil, {
     hide_from_history = true,
     icon = spinner_frames[new_spinner],
     replace = notif_data.notification,
   })

   vim.defer_fn(function()
     update_spinner(client_id, token)
   end, 100)
 end
end

local function format_title(title, client_name)
 return client_name .. (#title > 0 and ": " .. title or "")
end

local function format_message(message, percentage)
 return (percentage and percentage .. "%\t" or "") .. (message or "")
end

local coc_status_record = {}

function coc_status_notify(msg, level)
  local notify_opts = { title = "LSP Status", timeout = 500, hide_from_history = true, on_close = reset_coc_status_record }
  -- if coc_status_record is not {} then add it to notify_opts to key called "replace"
  if coc_status_record ~= {} then
    notify_opts["replace"] = coc_status_record.id
  end
  coc_status_record = vim.notify(msg, level, notify_opts)
end

function reset_coc_status_record(window)
  coc_status_record = {}
end

local coc_diag_record = {}

function coc_diag_notify(msg, level)
  local notify_opts = { title = "LSP Diagnostics", timeout = 5000, on_close = reset_coc_diag_record }
  -- if coc_diag_record is not {} then add it to notify_opts to key called "replace"
  if coc_diag_record ~= {} then
    notify_opts["replace"] = coc_diag_record.id
  end
  coc_diag_record = vim.notify(msg, level, notify_opts)
end

function reset_coc_diag_record(window)
  coc_diag_record = {}
end
vim.cmd([[
function! s:DiagnosticNotify() abort
  let l:info = get(b:, 'coc_diagnostic_info', {})
  if empty(l:info) | return '' | endif
  let l:msgs = []
  let l:level = 'info'
   if get(l:info, 'warning', 0)
    let l:level = 'warn'
  endif
  if get(l:info, 'error', 0)
    let l:level = 'error'
  endif

  if get(l:info, 'error', 0)
    call add(l:msgs, ' Errors: ' . l:info['error'])
  endif
  if get(l:info, 'warning', 0)
    call add(l:msgs, ' Warnings: ' . l:info['warning'])
  endif
  if get(l:info, 'information', 0)
    call add(l:msgs, ' Infos: ' . l:info['information'])
  endif
  if get(l:info, 'hint', 0)
    call add(l:msgs, ' Hints: ' . l:info['hint'])
  endif
  let l:msg = join(l:msgs, "\n")
  if empty(l:msg) | let l:msg = ' All OK' | endif
  call v:lua.coc_diag_notify(l:msg, l:level)
endfunction

function! s:StatusNotify() abort
  let l:status = get(g:, 'coc_status', '')
  let l:level = 'info'
  if empty(l:status) | return '' | endif
	  call v:lua.coc_status_notify(l:status, l:level)
endfunction


function! s:InitCoc() abort
  execute "lua vim.notify('Initialized coc.nvim for LSP support', 'info', { title = 'LSP Status' })"
endfunction

" notifications
autocmd User CocNvimInit call s:InitCoc()
autocmd User CocDiagnosticChange call s:DiagnosticNotify()
autocmd User CocStatusChange call s:StatusNotify()
]]
