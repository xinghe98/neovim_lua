require("dashboard").setup({
	--[[ theme = "hyper",
	config = {
		week_header = {
			enable = true,
		},
		shortcut = {
			{ desc = " Update", group = "@property", action = "Lazy update", key = "u" },
			{
				desc = " Files",
				group = "Label",
				action = "Telescope find_files",
				key = "f",
			},
		},
	}, ]]
	theme = "hyper",
	config = {
		week_header = {
			enable = true,
		},
		shortcut = {
			{ desc = "󰊳 Update", group = "@property", action = "Lazy update", key = "u" },
			{
				icon = " ",
				icon_hl = "@variable",
				desc = "Files",
				group = "Label",
				action = "Telescope find_files",
				key = "f",
			},
			{
				desc = " NeovimConf",
				group = "DiagnosticHint",
				action = "edit ~/.config/nvim/init.lua",
				key = "n",
			},
			{
				desc = " dotfiles",
				group = "Number",
				action = "edit ~/.config/",
				key = "d",
			},
			{
				desc = "󱠿 Project",
				group = "DiagnosticHint",
				action = "edit ~/Project/",
				key = "p",
			},
		},
	},
})
