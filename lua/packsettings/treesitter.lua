require("nvim-treesitter.configs").setup {
	ignore_install = { "help" },
	ensure_installed = { "go", "python", "typescript", "markdown", "markdown_inline", "query", "c", "vim", "html", "vue" },
	highlight = {
		enable = true,
		disable = { "lua" },
	},
	-- ...
}
