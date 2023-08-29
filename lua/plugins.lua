local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- lsp config
	{
		"williamboman/mason.nvim",
	},
	{ "williamboman/mason-lspconfig.nvim" },
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		config = function()
			require("lsp/mason")
		end,
	},
	{ "neovim/nvim-lspconfig" },
	{
		"hrsh7th/nvim-cmp",
		config = function()
			require("lsp.cmp")
		end,
	},
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "saadparwaiz1/cmp_luasnip" }, -- Snippets source for nvim-cmp
	{ "rafamadriz/friendly-snippets" }, -- Snippets (vscode-like) collection for different languages
	{
		"L3MON4D3/LuaSnip", -- Snippets plugin
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
	{ "ray-x/lsp_signature.nvim" },
	-- use 'hrsh7th/cmp-nvim-lsp-signature-help'
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-nvim-lua" },
	{ "hrsh7th/cmp-look" },
	{ "f3fora/cmp-spell" },
	{ "hrsh7th/cmp-cmdline" },
	{
		"nvimdev/lspsaga.nvim",
		-- after = "nvim-lspconfig",
		config = function()
			require("lspsaga").setup({})
		end,
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
			--Please make sure you install markdown and markdown_inline parser
			{ "nvim-treesitter/nvim-treesitter" },
		},
	},
	{
		"stevearc/conform.nvim",
		config = function()
			require("packsettings.conform")
		end,
	},
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},
	--------lsp end -------------------
	{
		"glepnir/dashboard-nvim",
		config = function()
			require("packsettings.dashboard")
		end,
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"liuchengxu/vista.vim",
		config = function()
			require("packsettings.vista")
		end,
	},
	{ "mg979/vim-visual-multi", branch = "master" },
	{ "posva/vim-vue" },
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("packsettings.treesitter")
		end,
	},
	{
		"HiPhish/nvim-ts-rainbow2",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("packsettings.rainbow")
		end,
	},
	{ "nvim-tree/nvim-web-devicons" },
	{
		"nvim-tree/nvim-tree.lua",
		config = function()
			require("packsettings.nvimtree")
		end,
		version = "nightly",
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "kyazdani42/nvim-web-devicons", lazy = true },
		config = function()
			require("packsettings.lualine")
		end,
	},
	{ "voldikss/vim-translator" },
	{ "tpope/vim-surround" },
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("packsettings.indentline")
		end,
	},
	{ "xiyaowong/nvim-cursorword" },
	{
		"akinsho/bufferline.nvim",
		version = "v3.*",
		config = function()
			require("packsettings.bufferline")
		end,
	},
	-- 快速注释
	{
		"b3nj5m1n/kommentary",
		config = function()
			require("packsettings.kommentary")
		end,
	},
	-- 终端悬浮窗
	{ "voldikss/vim-floaterm" },
	-- 文件搜索插件
	{
		"nvim-telescope/telescope.nvim",
		version = "0.1.1",
		dependencies = {
			"nvim-lua/plenary.nvim", -- Lua 开发模块
			"BurntSushi/ripgrep", -- 文字查找
			"sharkdp/fd", -- 文件查找
		},
		config = function()
			require("packsettings.telescope")
		end,
	},
	-- Markdown
	{
		"iamcco/markdown-preview.nvim",
		config = function()
			require("packsettings.markdownpre")
		end,
	},
	{ "dhruvasagar/vim-table-mode" },
	{ "mzlogin/vim-markdown-toc" },
	{
		"dkarter/bullets.vim",
		config = function()
			require("packsettings.bullets")
		end,
	},
	{
		"fatih/vim-go",
		build = ":GoUpdateBinaries",
		config = function()
			require("packsettings.vimgo")
		end,
	},
	{
		"github/copilot.vim",
		config = function()
			require("packsettings/copilot")
		end,
	},
	{ "godlygeek/tabular" },
	--------一些美化啥的 -------------------
	{ "rcarriga/nvim-notify" },
	{ "folke/todo-comments.nvim" },
	{ "ap/vim-css-color" },
	{ "theniceboy/nvim-deus" },
	{ "marko-cerovac/material.nvim" },
	{ "rmehri01/onenord.nvim" },
	{ "folke/tokyonight.nvim" },
	{ "hardhackerlabs/theme-vim" },
})
