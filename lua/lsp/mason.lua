require("mason").setup({
	ui = {
		icons = {
			server_installed = "✓",
			server_pending = "➜",
			server_uninstalled = "✗"
		}
	}
})

require("mason-lspconfig").setup {
	ensure_installed = {
		"rust_analyzer",
		"pyright",
		"gopls"

	},
}
