require("conform").setup({
	-- format_on_save = true,
	log_level = vim.log.levels.OFF,
	format_on_save = {
		-- I recommend these options. See :help conform.format for details.
		lsp_fallback = true,
		timeout_ms = 500,
	},
	formatters_by_ft = {
		go = { formatters = { "gofumpt", "goimports" }, run_all_formatters = true },
		lua = { "stylua" },
		-- go = {formatters=""}
		-- Conform will use the first available formatter in the list
		javascript = { "prettier_d", "prettier" },
		typescript = { "prettier_d", "prettier" },
		vue = { "prettier_d" },
		-- Formatters can also be specified with additional options
		python = {
			formatters = { "isort", "black" },
			-- Run formatters one after another instead of stopping at the first success
			run_all_formatters = true,
		},
	},
})
