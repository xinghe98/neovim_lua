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
