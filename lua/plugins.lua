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
				dependencies = { "rafamadriz/friendly-snippets" },
				config = function()
					require("luasnip.loaders.from_vscode").lazy_load({
						paths = { "~/.local/share/nvim/lazy/friendly-snippets/snippets" },
					})
					-- require("luasnip.loaders.from_snipmate").lazy_load()
				end,
			},
			--[[ {
				"ray-x/lsp_signature.nvim",
			}, ]]

			{ "onsails/lspkind.nvim" },
			--[[ {
				"j-hui/fidget.nvim",
				event = "VeryLazy",
				config = function()
					require("lsp.fidget")
				end,
			}, ]]
			{
				"roobert/action-hints.nvim",
				config = function()
					require("action-hints").setup({
						template = {
							definition = { text = " ⊛", color = "#add8e6" },
							references = { text = " ↱%s", color = "#ff6666" },
						},
						use_virtual_text = true,
					})
				end,
			},
		},
		config = function()
			require("lsp.cmp")
		end,
	},
	{
		"nvimdev/lspsaga.nvim",
		-- after = "nvim-lspconfig",
		event = "LspAttach",
		init = function()
			require("lsp.lsp_saga")
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
	{
		"akinsho/flutter-tools.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"stevearc/dressing.nvim", -- optional for vim.ui.select
		},
		config = function()
			require("packsettings.flutterTool")
		end,
		ft = "dart",
	},

	{
		"MysticalDevil/inlay-hints.nvim",
		event = "LspAttach",
		dependencies = { "neovim/nvim-lspconfig" },
		config = function()
			require("inlay-hints").setup({
				commands = { enable = true }, -- Enable InlayHints commands, include `InlayHintsToggle`, `InlayHintsEnable` and `InlayHintsDisable`
				autocmd = { enable = true }, -- Enable the inlay hints on `LspAttach` event
			})
		end,
	},
	{
		"brenoprata10/nvim-highlight-colors",
		event = "VimEnter",
		config = function()
			require("nvim-highlight-colors").setup({})
		end,
	},

	--------lsp end -------------------
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
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
		"nvim-treesitter/nvim-treesitter",
		event = "VimEnter",
		build = ":TSUpdate",
		config = function()
			require("packsettings.treesitter")
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
			frequency = 360, -- check for updates every hour
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
		main = "ibl",
		dependencies = {
			"HiPhish/rainbow-delimiters.nvim",
		},
		opts = {
			scope = { enabled = false },
		},
		--[[ config = function()
			require("packsettings.indentline")
		end, ]]
	},
	{
		"echasnovski/mini.indentscope",
		version = "*",
		event = "BufRead", -- 事件触发插件加载
		opts = {
			mappings = {
				-- Textobjects
				object_scope = "",
				object_scope_with_border = "",

				-- Motions (jump to respective border line; if not present - body line)
				goto_top = "[t",
				goto_bottom = "]t",
			},
			symbol = "┃", -- 缩进线的符号lp
			options = { try_as_border = true }, -- 配置项
		},
		init = function()
			-- 禁用特定文件类型的缩进高亮
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"help",
					"alpha",
					"dashboard",
					"lazy",
					"mason",
					"neo-tree",
					"Trouble",
					"toggleterm",
				},
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
	},
	{ "xiyaowong/nvim-cursorword", lazy = false },
	{
		"akinsho/bufferline.nvim",
		event = "VimEnter",
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
		tag = "0.1.8",
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
		ft = "markdown",
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
		ft = "go",
		build = ":GoUpdateBinaries",
		config = function()
			require("packsettings.vimgo")
		end,
	},
	--[[ {
		"github/copilot.vim",
		lazy = false,
		event = "VimEnter",
		config = function()
			vim.g.copilot_enabled = true
			vim.g.copilot_no_tab_map = true
			vim.g.copilot_no_cr_map = true
		end,
	}, ]]
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
		-- stylua: ignore
		keys = {
			{ "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
			{ "<A-s>", mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
			{ "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
			{ "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
			{ "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
		},
	},
	-- 快速替换插件
	{
		"chrisgrieser/nvim-rip-substitute",
		cmd = "RipSubstitute",
		keys = {
			{
				"<C-h>",
				function()
					require("rip-substitute").sub()
				end,
				mode = { "n", "x" },
			},
		},
		config = function()
			require("packsettings.quickreplace")
		end,
	},

	--------一些美化啥的 -------------------
	{ "rcarriga/nvim-notify" },
	{ "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" }, event = "VimEnter" },
	{ "ap/vim-css-color", event = "VimEnter", lazy = false },
	{ "theniceboy/nvim-deus", lazy = false, priority = 1000 },
	{ "olimorris/onedarkpro.nvim", lazy = false, priority = 1000 },
	{ "hardhackerlabs/theme-vim", lazy = false, priority = 1000 },
	{ "rmehri01/onenord.nvim", lazy = false, priority = 1000 },
	{ "folke/tokyonight.nvim", lazy = false, priority = 1000 },
	{ "ellisonleao/gruvbox.nvim", lazy = false, priority = 1000 },
	{ "marko-cerovac/material.nvim", lazy = false, priority = 1000 },
	-- lazy.nvim
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- add any options here
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
		config = function()
			require("packsettings.noice")
		end,
	},
}, { defaults = { lazy = true } })
