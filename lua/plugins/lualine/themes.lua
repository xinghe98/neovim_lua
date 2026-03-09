local colors = require("plugins.lualine.colors")

local M = {}

function M.get_theme()
	return {
		normal = {
			a = { fg = colors.black, bg = colors.blue },
			b = { fg = colors.white, bg = "NONE" },
			c = { fg = colors.white, bg = "NONE" },
			x = { fg = colors.white, bg = "NONE" },
			y = { fg = colors.white, bg = "NONE" },
			z = { fg = colors.black, bg = colors.blue, gui = "bold" },
		},
		insert = {
			a = { fg = colors.black, bg = colors.green },
			b = { fg = colors.white, bg = colors.dark },
			c = { fg = colors.white, bg = "NONE" },
			x = { fg = colors.white, bg = "NONE" },
			y = { fg = colors.white, bg = colors.grey },
			z = { fg = colors.black, bg = colors.green, gui = "bold" },
		},
		visual = {
			a = { fg = colors.black, bg = colors.magenta },
			b = { fg = colors.white, bg = colors.dark },
			c = { fg = colors.white, bg = "NONE" },
			x = { fg = colors.white, bg = "NONE" },
			y = { fg = colors.white, bg = colors.grey },
			z = { fg = colors.black, bg = colors.magenta, gui = "bold" },
		},
		replace = {
			a = { fg = colors.black, bg = colors.red },
			b = { fg = colors.black, bg = colors.dark },
			c = { fg = colors.white, bg = "NONE" },
			x = { fg = colors.white, bg = "NONE" },
			y = { fg = colors.white, bg = colors.grey },
			z = { fg = colors.black, bg = colors.red, gui = "bold" },
		},
		command = {
			a = { fg = colors.black, bg = colors.gold },
			b = { fg = colors.white, bg = colors.dark },
			c = { fg = colors.white, bg = "NONE" },
			x = { fg = colors.white, bg = "NONE" },
			y = { fg = colors.white, bg = colors.grey },
			z = { fg = colors.black, bg = colors.gold, gui = "bold" },
		},
		inactive = {
			a = { fg = colors.grey, bg = colors.dark },
			b = { fg = colors.grey, bg = colors.dark },
			c = { fg = colors.grey, bg = "NONE" },
			x = { fg = colors.grey, bg = "NONE" },
			y = { fg = colors.grey, bg = colors.dark },
			z = { fg = colors.grey, bg = colors.dark },
		},
	}
end

return M
