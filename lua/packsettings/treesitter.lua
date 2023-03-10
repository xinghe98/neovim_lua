require("nvim-treesitter.configs").setup {
	ensure_installed = { "go", "python", "typescript", "lua" },
	highlight = {
		-- ...

		enable = true,
	},
	-- ...
	rainbow = {
		enable = true,
		-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = nil, -- Do not enable for files with more than n lines, int
		colors = {
			'#e8b622',
			'#59dd5d',
			'#21a2ff',
			'#e669da',
			'#00D1c1',
			'#d65d0e',
			'#458588'

		}, -- table of hex strings
		-- termcolors = {} -- table of colour name strings
	}
}
require 'nvim-treesitter.install'.compilers = { 'zig' }
