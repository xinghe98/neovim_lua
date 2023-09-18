local builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-f>", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
require("telescope").setup({
	extensions = {
		coc = {
			theme = 'dropdown',
			prefer_locations = true, -- always use Telescope locations to preview definitions/declarations/implementations etc
		}
	},
})
require('telescope').load_extension('coc')
