local keymap = vim.api.nvim_set_keymap
local opts ={noremap= true,silent=true}
keymap('n','H' ,'^',opts)
keymap('n','L', '$',opts)
keymap('n','<leader>l', '<C-w>l',opts)
keymap('n','<leader>k', '<C-w>k',opts)
keymap('n','<leader>h', '<C-w>h',opts)
keymap('n','<leader>j', '<C-w>j',opts)
keymap('n','<S-Tab>', '<<',opts)
keymap('n','<Tab>', '>>',opts)
keymap('v','<S-Tab>', '<',opts)
keymap('v','<Tab>', '>',opts)
