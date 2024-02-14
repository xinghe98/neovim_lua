vim.o.langmap = "ej,je,JE,EJ"
vim.o.langmap = "nh,hn,HN,NH"
vim.o.langmap = "he,eh,HE,EH"
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
keymap("", ";", ":", opts)
keymap("", "Y", "\"+y", opts)
keymap("", "`", "~", opts)

-- Movement
keymap("", "u", "k", opts)
--[[ keymap("", "e", "j", opts)
keymap("", "n", "h", opts)
keymap("", "h", "e", opts) ]]
keymap("", "i", "l", opts)
keymap("", "U", "5k", opts)
keymap("", "E", "5j", opts)
keymap("", "N", "0", opts)
keymap("", "I", "$", opts)
keymap("", "gu", "gk", opts)
keymap("", "ge", "gj", opts)
keymap("", "<C-U>", "5<C-y>", opts)
keymap("", "<C-E>", "5<C-e>", opts)
keymap("", "ci", "cl", opts)
keymap("", "cn", "ch", opts)
keymap("", "ck", "ci", opts)
keymap("", "c,.", "c%", opts)
keymap("", "yh", "ye", opts)

-- Actions
keymap("", "l", "u", opts)
keymap("", "k", "i", opts)
keymap("", "K", "I", opts)

keymap("", "H", "^", opts)
keymap("", "L", "$", opts)
keymap("n", "o", "zzo", opts)
keymap("n", "O", "zzO", opts)
keymap("n", "<leader>i", "<C-w>l", opts)
keymap("n", "<leader>u", "<C-w>k", opts)
keymap("n", "<leader>n", "<C-w>h", opts)
keymap("n", "<leader>e", "<C-w>j", opts)
keymap("n", "<S-Tab>", "<<", opts)
keymap("n", "<Tab>", ">>", opts)
keymap("v", "<S-Tab>", "<", opts)
keymap("v", "<Tab>", ">", opts)
keymap("n", "qq", ":nohlsearch<CR>", opts)
keymap("n", "<S-s>", ":w<CR>", opts)
keymap("n", "<S-q>", ":q<CR>", opts)
--[[ keymap('n','<leader><leader>p', ':set paste<CR>',opts)
keymap('n', '<leader>np', ':set nopaste<CR>',opts) ]]
keymap("n", "r", ":call CompileRunGcc()<CR>", opts)
keymap("n", "<leader>t", ":TranslateW<CR>", opts)
keymap("v", "<leader>t", ":TranslateW<CR>", opts)
keymap("n", "<C-t>", ":FloatermToggle<CR>", opts)
keymap("t", "<C-t>", "<C-\\><C-n>:FloatermToggle<CR>", opts)
-- tab标签页跳转
keymap("n", "<leader>1", ":BufferLineGoToBuffer 1<CR>", opts)
keymap("n", "<leader>2", ":BufferLineGoToBuffer 2<CR>", opts)
keymap("n", "<leader>3", ":BufferLineGoToBuffer 3<CR>", opts)
keymap("n", "<leader>4", ":BufferLineGoToBuffer 4<CR>", opts)
keymap("n", "<leader>5", ":BufferLineGoToBuffer 5<CR>", opts)
keymap("n", "<leader>6", ":BufferLineGoToBuffer 6<CR>", opts)
keymap("n", "<leader><leader>", ":bn<CR>", opts)
keymap("n", "<leader><backspace>", ":bp<CR>", opts)
keymap("n", "<c-w>", ":bd<CR>", opts)
-- nvim-tree
keymap("n", "tt", ":NvimTreeFindFileToggle<CR>", opts)
-- copilot
keymap("i", "<C-e>", 'copilot#Accept("<CR>")', { script = true, silent = true, expr = true })
-- todo comments
keymap("n", "<leader>ft", ":TodoTelescope<CR>", opts)
vim.keymap.set("n", "]t", function()
	require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
	require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

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
