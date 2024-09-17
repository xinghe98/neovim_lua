local builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-f>", builtin.find_files, {})
vim.keymap.set("n", "<C-g>", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
vim.keymap.set("n", "<C-x>", ":Telescope flutter commands<CR>", {})
require("telescope").setup({
	defaults = {
		sorting_strategy = "ascending",
		file_ignore_patterns = {
			"%.env",
			"yarn.lock",
			"package-lock.json",
			"lazy-lock.json",
			"init.sql",
			"target/.*",
			".git/.*",
			"node_modules",
			"dist",
		},
		mappings = {
			i = {
				-- map actions.which_key to <C-h> (default: <C-/>)
				-- actions.which_key shows the mappings for your picker,
				-- e.g. git_{create, delete, ...}_branch for the git_branches picker
				["<Tab>"] = "move_selection_next",
				["<S-Tab>"] = "move_selection_previous",
				["<C-u>"] = "preview_scrolling_up",
				["<C-e>"] = "preview_scrolling_down",
			},
		},
	},
	extensions = {
		coc = {
			theme = 'dropdown',
			prefer_locations = true, -- always use Telescope locations to preview definitions/declarations/implementations etc
		}
	},
})

require('telescope').load_extension('coc')
require("telescope").load_extension("flutter")
