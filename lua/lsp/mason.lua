require("mason").setup({
	ui = {
		icons = {
			server_installed = "✓",
			server_pending = "➜",
			server_uninstalled = "✗",
		},
	},
})

--[[ require("mason-lspconfig").setup({
	ensure_installed = {},
}) ]]
require("mason-tool-installer").setup({

	-- a list of all tools you want to ensure are installed upon
	-- start; they should be the names Mason uses for each tool
	ensure_installed = {
		"lua_ls",
		"gopls",
		"volar",
		-- "tsserver",
		"ts_ls",
		"jsonls",
		"gofumpt",
		"goimports",
		"prettier",
		"prettierd",
		"stylua",
		-- "emmet-ls",
		"emmet-language-server",
		"css-lsp",
	},
})
