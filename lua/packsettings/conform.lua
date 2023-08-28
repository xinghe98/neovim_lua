require("conform").setup({
	-- format_on_save = true,
	formatters_by_ft = {
		lua = { "stylua" },
		-- go = {formatters=""}
		-- Conform will use the first available formatter in the list
		javascript = { "prettier_d", "prettier" },
		typescript = { "prettier_d", "prettier" },
		-- Formatters can also be specified with additional options
		python = {
			formatters = { "isort", "black" },
			-- Run formatters one after another instead of stopping at the first success
			run_all_formatters = true,
		},
	},
})
