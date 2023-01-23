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
keymap('n', '<S-j>', '5j',opts)
keymap('n', 'K', '5k',opts)
keymap('n', 'qq', ':nohlsearch<CR>',opts)
keymap('n', '<leader><leader>', ':bn<CR>',opts)
keymap('n', '<leader><backspace>', ':bp<CR>',opts)
keymap('n', '<c-w>', ':bd<CR>',opts)
keymap('n', '<S-s>', ':w<CR>',opts)
keymap('n', '<S-q>', ':q<CR>',opts)
keymap('i', '<C-a>', '<Home>',opts)
keymap('i','<C-e>', '<End>',opts)
keymap('n','<leader><leader>p', ':set paste<CR>',opts)
keymap('n', '<leader>np', ':set nopaste<CR>',opts)