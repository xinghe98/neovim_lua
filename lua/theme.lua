require("onedarkpro").setup({
	styles = {
		comments = "bold",
		properties = "bold",
		functions = "bold",
		keywords = "italic",
		operators = "bold",
		conditionals = "italic",
		loops = "italic",
		booleans = "bold,italic",
	},
})
vim.cmd("colorscheme onedark")
-- vim.cmd("colorscheme material")
-- vim.cmd("colorscheme hardhacker")
--[[ require("onenord").setup({
	theme = nil, -- "dark" or "light". Alternatively, remove the option and set vim.o.background instead
	borders = true, -- Split window borders
	fade_nc = false, -- Fade non-current windows, making them more distinguishable
	-- Style that is applied to various groups: see `highlight-args` for options
	styles = {
		comments = "NONE",
		strings = "NONE",
		keywords = "NONE",
		functions = "NONE",
		variables = "NONE",
		diagnostics = "underline",
	},
	disable = {
		background = false, -- Disable setting the background color
		cursorline = false, -- Disable the cursorline
		eob_lines = true, -- Hide the end-of-buffer lines
	},
	-- Inverse highlight for different groups
	inverse = {
		match_paren = false,
	},
	custom_highlights = {}, -- Overwrite default highlight groups
	custom_colors = {}, -- Overwrite default colors
})
require("onenord.colors").load() ]]
