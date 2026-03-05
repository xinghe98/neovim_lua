local Util = require("lazyvim.util")
-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local opt = { noremap = true }
-- vim.o.langmap = "uk,lu,il,ki,ej,je"
keymap("", ";", ":", opt)
keymap("", "Y", '"+y', opt)

-- Movement
keymap("", "n", "h", opt)
keymap("", "e", "j", opt)
keymap("", "u", "k", opt)
keymap("", "i", "l", opt)
keymap("", "h", "e", opt)
keymap("", "m", "n", opt)
keymap("", "M", "N", opt)

keymap("n", "'", "m", opt)

keymap("", "U", "5k", opts)
keymap("", "E", "5j", opts)
keymap("", "N", "0", opts)
keymap("", "I", "$", opts)
keymap("", "<C-U>", "5<C-y>", opts)
keymap("", "<C-E>", "5<C-e>", opts)
keymap("", "yh", "ye", opts)

-- Actions
keymap("", "l", "u", opts)
keymap("", "k", "i", opts)
keymap("", "K", "I", opts)
keymap("", "C", "~", opts)
keymap("", "W", "b", opts)
-- keymap("v", "k", "xi", opts)
keymap("n", "<C-k>", "<C-i>", opts)

keymap("n", "<S-Tab>", "<<", opts)
keymap("n", "<Tab>", ">>", opts)
keymap("v", "<S-Tab>", "<", opts)
keymap("v", "<Tab>", ">", opts)
keymap("n", "qq", ":nohlsearch<CR>", opts)
keymap("n", "<S-s>", ":w<CR>", opts)
-- ordinary Neovim
keymap("n", "<S-q>", ":q<CR>", opts)
keymap("n", "<leader>t", ":TranslateW<CR>", opts)
keymap("v", "<leader>t", ":TranslateW<CR>", opts)
--[[ keymap('n','<leader><leader>p', ':set paste<CR>',opts)
	keymap('n', '<leader>np', ':set nopaste<CR>',opts) ]]
keymap("n", "<leader>i", "<C-w>l", opts)
keymap("n", "<leader>u", "<C-w>k", opts)
keymap("n", "<leader>n", "<C-w>h", opts)
keymap("n", "<leader>e", "<C-w>j", opts)
keymap("n", "r", ":call CompileRunGcc()<CR>", opts)
-- keymap("n", "<C-t>", ":FloatermToggle<CR>", opts)
-- keymap("t", "<C-t>", "<C-\\><C-n>:FloatermToggle<CR>", opts)
local lazyterm = function()
  Util.terminal(nil, { cwd = Util.root() })
end
vim.keymap.set("n", "<C-t>", lazyterm, { desc = "Terminal (Root Dir)" })
vim.keymap.set("t", "<C-t>", "<cmd>close<cr>", { desc = "Hide Terminal" })
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
vim.keymap.del("n", "<c-/>")
vim.keymap.del("n", "<c-_>")
keymap("n", "<C-/>", "gcc", { desc = "Toggle comment for line" })
keymap("v", "<C-/>", "gc", { desc = "Toggle comment for selection" })
keymap("n", "<C-_>", "gcc", { desc = "Toggle comment for line" })
keymap("v", "<C-_>", "gc", { desc = "Toggle comment for line" })
-- nvim-tree
keymap("n", "tt", ":NvimTreeFindFileToggle<CR>", opts)

keymap("n", "<M-h>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
keymap("i", "<M-h>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)

vim.keymap.set("n", "]t", function()
  require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
  require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

-- 设置选择模式下所有字母（大小写）直接插入对应字符
for char = string.byte("a"), string.byte("z") do
  local lowercase_char = string.char(char)
  local uppercase_char = string.char(char - 32) -- 转换为大写字母

  -- 小写字母
  vim.keymap.set("s", lowercase_char, function()
    return lowercase_char
  end, { noremap = true, silent = true, expr = true })

  -- 大写字母
  vim.keymap.set("s", uppercase_char, function()
    return uppercase_char
  end, { noremap = true, silent = true, expr = true })
end

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
