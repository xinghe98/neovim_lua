-- bfferline 配置
-- https://github.com/akinsho/bufferline.nvim#configuration
require("bufferline").setup({
	options = {
		mode = "buffers",
		-- 显示id
		numbers = "ordinal",
		-- 侧边栏配置
		-- 左侧让出 nvim-tree 的位置，显示文字 File Explorer
		offsets = {
			{
				filetype = "NvimTree",
				text = "File Explorer",
				highlight = "Directory",
				text_align = "left",
			},
		},
		diagnostics = "coc",
		-- 可选，显示 LSP 报错图标
		---@diagnostic disable-next-line: unused-local
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			local s = " "
			for e, n in pairs(diagnostics_dict) do
				local sym = e == "error" and " " or (e == "warning" and " " or "")
				s = s .. n .. sym
			end
			return s
		end,
	},
})

