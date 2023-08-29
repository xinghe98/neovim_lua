require("conform").setup({
	-- format_on_save = true,
	log_level = vim.log.levels.ERROR,
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
		javascript = { "prettierd" },
		typescript = { "prettierd" },
		vue = { "prettierd" },
		-- Formatters can also be specified with additional options
		python = {
			formatters = { "isort", "black" },
			-- Run formatters one after another instead of stopping at the first success
			run_all_formatters = true,
		},
	},
})
--[[ vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	group = vim.api.nvim_create_augroup("NotifyClearGrp", {}),
	pattern = "*",
	callback = function()
		require("notify").dismiss({ silent = true })
	end,
}) ]]
