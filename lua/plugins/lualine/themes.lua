local colors = require("plugins.lualine.colors")

local M = {}

-- Get theme based on current mode
function M.get_theme()
	local mode = vim.fn.mode()
	local bg_color = colors.surface

	local theme = {
		normal   = { a = { bg = bg_color, fg = colors.white }, b = { bg = bg_color, fg = colors.white }, c = { bg = "NONE", fg = colors.white } },
		insert   = { a = { bg = bg_color, fg = colors.white }, b = { bg = bg_color, fg = colors.white }, c = { bg = "NONE", fg = colors.white } },
		visual   = { a = { bg = bg_color, fg = colors.white }, b = { bg = bg_color, fg = colors.white }, c = { bg = "NONE", fg = colors.white } },
		replace  = { a = { bg = bg_color, fg = colors.white }, b = { bg = bg_color, fg = colors.white }, c = { bg = "NONE", fg = colors.white } },
		command  = { a = { bg = bg_color, fg = colors.white }, b = { bg = bg_color, fg = colors.white }, c = { bg = "NONE", fg = colors.white } },
		inactive = { a = { bg = "NONE", fg = colors.surface_alt }, b = { bg = "NONE", fg = colors.surface_alt }, c = { bg = "NONE", fg = colors.surface_alt } },
	}

	return theme
end

return M
