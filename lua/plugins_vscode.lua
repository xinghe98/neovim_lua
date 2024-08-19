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
	{
		"tpope/vim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
	},
	{
		"shellRaining/hlchunk.nvim",
		init = function()
			require("packsettings.indentline")
		end,
	},
	{ "xiyaowong/nvim-cursorword", lazy = false },
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
	{
		"chentoast/marks.nvim",
		event = "VeryLazy",
		config = function()
			require("marks").setup({
				default_mappings = false,
				mappings = {
					set = "'",
					delete = "d'",
					delete_buf = "d'b",
					set_next = "',",
					next = "']",
					preview = "':",
					set_bookmark0 = "'0",
					prev = false, -- pass false to disable only this default mapping
				},
			})
		end,
	},
}, { defaults = { lazy = true } })
