local signature = require("lsp_signature")
signature.setup({
	bind = true,
	focusable = false,
	floating_window = true,
	floating_window_above_cur_line = true,
	hint_enable = true,
	always_trigger = false,
	check_completion_visible = false,
	hint_inline = function()
		return true
	end, -- should the hint be inline(nvim 0.10 only)?  default false
	-- return true | 'inline' to show hint inline, return 'eol' to show hint at end of line, return false to disable
	-- return 'right_align' to display hint right aligned in the current line
	fix_pos = false,
	-- floating_window_above_first = true,
	hi_parameter = "Search",
	zindex = 60,
	timer_interval = 100,
	hint_prefix = "🦊", -- Panda for parameter
	hint_scheme = "String",
	extra_trigger_chars = {},
	handler_opts = {
		border = "rounded",
	},
})
