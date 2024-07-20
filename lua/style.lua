require("todo-comments").setup()

vim.diagnostic.config({
	virtual_text = {
		prefix = "😥",
	},
})
require("notify").setup({
	-- other stuff
	background_colour = "#000000",
})
