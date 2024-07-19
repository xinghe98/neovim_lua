require("conform").setup({
	-- format_on_save = true,
	log_level = vim.log.levels.ERROR,
	notify_on_error = false,
	format_on_save = {
		-- I recommend these options. See :help conform.format for details.
		lsp_fallback = true,
		timeout_ms = 500,
	},
	formatters_by_ft = {
		go = { "gofumpt", "goimports" },
		lua = { "stylua" },
		-- go = {formatters=""}
		-- Conform will use the first available formatter in the list
		javascript = { "prettierd" },
		typescript = { "prettierd" },
		-- vue = { "volar", "prettierd" },
		-- Formatters can also be specified with additional options
		python = {
			"isort", "black"
			-- Run formatters one after another instead of stopping at the first success
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
