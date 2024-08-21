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

keymap("n", "<S-Tab>", "<<", opts)
keymap("n", "<Tab>", ">>", opts)
keymap("v", "<S-Tab>", "<", opts)
keymap("v", "<Tab>", ">", opts)
keymap("n", "qq", ":nohlsearch<CR>", opts)
keymap("n", "<S-s>", ":w<CR>", opts)
if vim.g.vscode then
	-- VSCode extension
	keymap("n", "tt",
		" <Cmd>lua require('vscode').action('workbench.action.toggleSidebarVisibility')<CR>",
		opts)

	keymap("n", "<C-w>", "<cmd>lua require('vscode').action('workbench.action.closeActiveEditor')<CR>", opts)

	-- lsp start
	keymap("n", "gh", "<Cmd>lua require('vscode').action('editor.action.showHover')<CR>", opts)
	keymap("n", "gd", "<Cmd>lua require('vscode').action('editor.action.revealDefinition')<CR>", opts)
	keymap("n", "gr", "<Cmd>lua require('vscode').action('editor.action.previewDeclaration')<CR>", opts)
else
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
	keymap("n", "<C-t>", ":FloatermToggle<CR>", opts)
	keymap("t", "<C-t>", "<C-\\><C-n>:FloatermToggle<CR>", opts)
	-- tab标签页跳转
	keymap("n", "<A-1>", ":BufferLineGoToBuffer 1<CR>", opts)
	keymap("n", "<A-2>", ":BufferLineGoToBuffer 2<CR>", opts)
	keymap("n", "<A-3>", ":BufferLineGoToBuffer 3<CR>", opts)
	keymap("n", "<A-4>", ":BufferLineGoToBuffer 4<CR>", opts)
	keymap("n", "<A-5>", ":BufferLineGoToBuffer 5<CR>", opts)
	keymap("n", "<A-6>", ":BufferLineGoToBuffer 6<CR>", opts)
	keymap("n", "<leader><leader>", ":bn<CR>", opts)
	keymap("n", "<leader><backspace>", ":bp<CR>", opts)
	keymap("n", "<c-w>", ":bd<CR>", opts)
	-- nvim-tree
	keymap("n", "tt", ":NvimTreeFindFileToggle<CR>", opts)
	-- copilot
	keymap("i", "<C-q>", 'copilot#Accept("<CR>")', { script = true, silent = true, expr = true })
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
end
