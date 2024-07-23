require("lspsaga").setup({
	scroll_preview = {
		scroll_down = "<C-e>",
		scroll_up = "<C-u>",
	},
	code_action = {
		show_server_name = true,
		keys = {
			quit = "<esc>",
			exec = "<CR>",
		},
	},
	rename = {
		keys = {
			quit = "<esc>",
		},
	},
})
