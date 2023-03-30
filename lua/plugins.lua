vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'
	use 'mhinz/vim-startify'
	use 'theniceboy/nvim-deus'
	use 'folke/tokyonight.nvim'
	use 'sainnhe/gruvbox-material'
	use { 'liuchengxu/vista.vim', config = function() require('packsettings.vista') end }
	use { 'rcarriga/nvim-notify', config = function() require('packsettings.notify') end }
	use 'h-hg/fcitx.nvim'
	use { 'mg979/vim-visual-multi', branch = 'master' }
	use 'posva/vim-vue'
	use 'rakr/vim-one'
	use { 'nvim-treesitter/nvim-treesitter', config = function()
		require('packsettings.treesitter')
	end }
	use { 'p00f/nvim-ts-rainbow' }
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true },
		config = function() require('packsettings.lualine') end
	}
	use 'nvim-tree/nvim-web-devicons'
	use {
		'nvim-tree/nvim-tree.lua',
		config = function() require('packsettings.nvimtree') end,
		tag = 'nightly' -- optional, updated every week. (see issue #1193)
	}
	use 'voldikss/vim-translator'
	use({
		"kylechui/nvim-surround",
		tag = "*", -- Use for stability; omit to use `main` branch for the latest features
		config = function()
			require("nvim-surround").setup({
			})
		end
	})
	use 'itchyny/vim-cursorword'
	use 'Yggdroot/indentLine'
	use {
		'neoclide/coc.nvim', branch = 'master', run = 'yarn install --frozen-lockfile',
		config = function() require('packsettings.coc') end
	}
	use 'neoclide/jsonc.vim'
	--[[ use {
	"windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
} ]]
	-- using packer.nvim
	use { 'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons',
		config = function() require('packsettings.bufferline') end }
	use 'tell-k/vim-autopep8'
	-- 快速注释
	use { 'b3nj5m1n/kommentary', config = function() require('packsettings.kommentary') end }
	-- 终端悬浮窗
	use 'voldikss/vim-floaterm'
	-- 文件搜索插件
	use 'nvim-lua/plenary.nvim'
	use { 'nvim-telescope/telescope.nvim', tag = '0.1.1',
		requires = {
			"nvim-lua/plenary.nvim", -- Lua 开发模块
			"BurntSushi/ripgrep", -- 文字查找
			"sharkdp/fd"    -- 文件查找
		},
		config = function() require('packsettings.telescope') end }
	-- Markdown
	use { 'iamcco/markdown-preview.nvim' }
	use 'dhruvasagar/vim-table-mode'
	use 'mzlogin/vim-markdown-toc'
	use { 'dkarter/bullets.vim', config = function() require('packsettings.bullets') end }
	use { 'fatih/vim-go', run = ':GoUpdateBinaries', config = function() require('packsettings.vimgo') end }
	-- Remove the `use` here if you're using folke/lazy.nvim.
	use {
		'Exafunction/codeium.vim',
		config = function()
			-- Change '<C-g>' here to any keycode you like.
			vim.keymap.set('i', '<C-e>', function() return vim.fn['codeium#Accept']() end, { expr = true })
			vim.keymap.set('i', '<C-n>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
			vim.keymap.set('i', '<C-p>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
			vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
		end
	}
	--[[ require('packsettings/copilot').config()
	use { 'github/copilot.vim', config = "require('packsettings/copilot').setup()", event = 'InsertEnter' } ]]
	use 'godlygeek/tabular'
	use "folke/todo-comments.nvim"
	-- 你可以在这里定义你所需要的插件列表
end)
