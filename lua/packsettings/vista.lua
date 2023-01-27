local keymap = vim.api.nvim_set_keymap
local opts ={noremap= true,silent=true}
keymap('n', 'tg', ':Vista!!<CR>',opts)
vim.cmd([[
autocmd bufenter * if (winnr("$") == 1 && &filetype == "Vista") | q | endif
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_default_executive = 'ctags'

let g:vista_executive_for = {
  \ 'cpp': 'vim_lsp',
  \ 'php': 'vim_lsp',
  \ }

let g:vista_ctags_cmd = {
      \ 'haskell': 'hasktags -x -o - -c',
      \ }

let g:vista#renderer#enable_icon = 1

" The default icons can't be suitable for all the filetypes, you can extend it as you wish.
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }
]])

