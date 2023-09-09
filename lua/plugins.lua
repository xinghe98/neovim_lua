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
--config.defaults.lazy = true
require("lazy").setup({
	-- lsp config
	{
		"williamboman/mason.nvim",
	},
	{ "williamboman/mason-lspconfig.nvim" },
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		lazy = false,
		config = function()
			require("lsp/mason")
		end,
	},
	{ "neovim/nvim-lspconfig" },

	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-nvim-lua" },
			{ "hrsh7th/cmp-look" },
			{ "f3fora/cmp-spell" },
			-- { "hrsh7th/cmp-cmdline" },
			{ "hrsh7th/cmp-calc" },
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
		},
		config = function()
			require("lsp.cmp")
		end,
	},
	{
		"nvimdev/lspsaga.nvim",
		-- after = "nvim-lspconfig",
		event = "VimEnter",
		config = function()
			require("lspsaga").setup({})
		end,
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
			--Please make sure you install markdown and markdown_inline parser
			{ "nvim-treesitter/nvim-treesitter" },
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
		},
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
		event = "BufEnter",
		config = function()
			require("packsettings.vista")
		end,
	},
	{ "mg979/vim-visual-multi", branch = "master", lazy = false },
	{
		"HiPhish/nvim-ts-rainbow2",
		event = "VimEnter",
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter",
				event = "VimEnter",
				build = ":TSUpdate",
				config = function()
					require("packsettings.treesitter")
				end,
			},
		},
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
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		version = "*",
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "VimEnter",
		lazy = false,
		checker = {
			-- automatically check for plugin updates
			enabled = true,
			concurrency = nil, ---@type number? set to 1 to check for updates very slowly
			notify = true, -- get a notification when new updates are found
			frequency = 3600, -- check for updates every hour
		},
		config = function()
			require("packsettings.lualine")
		end,
	},
	{ "voldikss/vim-translator", event = "BufEnter" },
	{
		"tpope/vim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufEnter",
		config = function()
			require("packsettings.indentline")
		end,
	},
	{ "xiyaowong/nvim-cursorword", lazy = false },
	{
		"akinsho/bufferline.nvim",
		event = "BufNew",
		version = "v3.*",
		config = function()
			require("packsettings.bufferline")
		end,
	},
	-- 快速注释
	{
		"b3nj5m1n/kommentary",
		event = "VeryLazy",
		config = function()
			require("packsettings.kommentary")
		end,
	},
	-- 终端悬浮窗
	{ "voldikss/vim-floaterm", lazy = false },
	-- 文件搜索插件
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.2",
		event = "VimEnter",
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
		lazy = false,
		config = function()
			require("packsettings.markdownpre")
		end,
		dependencies = {

			{ "dhruvasagar/vim-table-mode" },
			{ "mzlogin/vim-markdown-toc" },
			{ "godlygeek/tabular" },
			{
				"dkarter/bullets.vim",
				config = function()
					require("packsettings.bullets")
				end,
			},
		},
	},
	{
		"fatih/vim-go",
		lazy = false,
		build = ":GoUpdateBinaries",
		config = function()
			require("packsettings.vimgo")
		end,
	},
	{
		"github/copilot.vim",
		-- lazy = false,
		event = "InsertEnter",
		config = function()
			vim.g.copilot_enabled = true
			vim.g.copilot_no_tab_map = true
			vim.g.copilot_no_cr_map = true
		end,
	},
	--------一些美化啥的 -------------------
	{ "rcarriga/nvim-notify" },
	{ "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" }, event = "VimEnter" },
	{ "ap/vim-css-color", event = "VimEnter", lazy = false },
	{ "theniceboy/nvim-deus", lazy = false, priority = 1000 },
	{ "marko-cerovac/material.nvim", lazy = false, priority = 1000 },
	{ "rmehri01/onenord.nvim", lazy = false, priority = 1000 },
	{ "folke/tokyonight.nvim", lazy = false, priority = 1000 },
	{ "hardhackerlabs/theme-vim", lazy = false, priority = 1000 },
}, { defaults = { lazy = true } })
