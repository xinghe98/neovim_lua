local builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-f>", builtin.find_files, {})
vim.keymap.set("n", "<C-g>", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
vim.keymap.set("n", "<C-x>", ":Telescope flutter commands<CR>", {})
require("telescope").setup({
	defaults = {
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
	},
})
require("telescope").load_extension("flutter")
