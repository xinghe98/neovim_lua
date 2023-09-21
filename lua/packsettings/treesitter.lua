require("nvim-treesitter.configs").setup {
	ensure_installed = { "go", "python", "typescript", "lua", "markdown", "markdown_inline", "query", "c", "vim", "html",
		"vue" },
	highlight = {
		enable = true,
	},
	-- ...
}
