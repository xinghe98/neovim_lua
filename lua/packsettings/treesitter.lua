require("nvim-treesitter.configs").setup {
	ignore_install = { "help" },
	ensure_installed = { "vim", "vimdoc", "go", "python", "typescript", "markdown", "markdown_inline", "query", "c", "vim", "html", "vue", "lua", "dart" },
	highlight = {
		enable = true,
	},
	-- ...
}
