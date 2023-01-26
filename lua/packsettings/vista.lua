local keymap = vim.api.nvim_set_keymap
local opts ={noremap= true,silent=true}
keymap('n', 'tg', ':Vista!!<CR>',opts)
vim.cmd([[
autocmd bufenter * if (winnr("$") == 1 && &filetype == "Vista") | q | endif
]])
vim.g.vista_icon_indent = {"╰─▸ ", "├─▸ "}

vim.g.vista_default_executive = 'coc'

