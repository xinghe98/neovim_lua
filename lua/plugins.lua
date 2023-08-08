vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'
	-- lsp config
	use {
		'williamboman/mason.nvim',
		config = function()
			require('lsp/mason')
		end
	}
	use 'williamboman/mason-lspconfig.nvim'
	use 'neovim/nvim-lspconfig'
	use { 'hrsh7th/nvim-cmp', config = function() require('lsp.cmp') end }
	use 'hrsh7th/cmp-nvim-lsp'
	use 'saadparwaiz1/cmp_luasnip'  -- Snippets source for nvim-cmp
	use 'rafamadriz/friendly-snippets' -- Snippets (vscode-like) collection for different languages
	use {
		'L3MON4D3/LuaSnip',         -- Snippets plugin
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end
	}
	use "ray-x/lsp_signature.nvim"
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-nvim-lua'
	use 'hrsh7th/cmp-look'
	use 'f3fora/cmp-spell'
	use 'hrsh7th/cmp-cmdline'
	--[[ use({
		"hrsh7th/cmp-emoji",
		config = function()
			require 'cmp'.setup {
				sources = {
					{ name = 'emoji' }
				}
			}
		end
	}) ]]
	use({
		'nvimdev/lspsaga.nvim',
		after = 'nvim-lspconfig',
		config = function()
			require('lspsaga').setup({})
		end,
		requires = {
			{ "nvim-tree/nvim-web-devicons" },
			--Please make sure you install markdown and markdown_inline parser
			{ "nvim-treesitter/nvim-treesitter" }
		}
	})
	--------lsp end -------------------
	-- use 'mhinz/vim-startify'
	use {
		'glepnir/dashboard-nvim',
		config = function() require('packsettings.dashboard') end,
		requires = { 'nvim-tree/nvim-web-devicons' }
	}
	use 'theniceboy/nvim-deus'
	use 'marko-cerovac/material.nvim'
	use 'folke/tokyonight.nvim'
	use { 'liuchengxu/vista.vim', config = function() require('packsettings.vista') end }
	use 'h-hg/fcitx.nvim'
	use { 'mg979/vim-visual-multi', branch = 'master' }
	use 'posva/vim-vue'
	use { 'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
		config = function()
			require('packsettings.treesitter')
		end }
	use { 'p00f/nvim-ts-rainbow' }
	use 'nvim-tree/nvim-web-devicons'
	use {
		'nvim-tree/nvim-tree.lua',
		config = function() require('packsettings.nvimtree') end,
		tag = 'nightly'
	}
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true },
		config = function() require('packsettings.lualine') end
	}
	use 'voldikss/vim-translator'
	use "tpope/vim-surround"
	use {
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require('packsettings.indentline')
		end
	}
	use {
		"windwp/nvim-autopairs",
		config = function() require("nvim-autopairs").setup {} end
	}
	use 'xiyaowong/nvim-cursorword'
	use { 'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons',
		config = function() require('packsettings.bufferline') end }
	-- 快速注释
	use { 'b3nj5m1n/kommentary', config = function() require('packsettings.kommentary') end }
	-- 终端悬浮窗
	use 'voldikss/vim-floaterm'
	-- 文件搜索插件
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
	use { 'github/copilot.vim', config = function() require('packsettings/copilot') end }
	use 'godlygeek/tabular'
	---------------通知美化相关
	use 'rcarriga/nvim-notify'
	use "folke/todo-comments.nvim"
	use 'ap/vim-css-color'
	--[[ use { 'j-hui/fidget.nvim',tag='legacy', config = function()
		require "fidget".setup {}
	end }
	use { "ybian/smartim", event = { "InsertEnter" }, config = function()
		-- default IME mode
		vim.g.smartim_default = "com.apple.keylayout.ABC"
	end } ]]
	-- 你可以在这里定义你所需要的插件列表
end)
