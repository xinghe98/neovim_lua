local signature = require("lsp_signature")
signature.setup({
	bind = true,
	focusable = false,
	floating_window = true,
	floating_window_above_cur_line = true,
	hint_enable = true,
	fix_pos = false,
	-- floating_window_above_first = true,
	hi_parameter = "Search",
	zindex = 60,
	timer_interval = 100,
	hint_prefix = "🦊", -- Panda for parameter
	hint_scheme = "String",
	extra_trigger_chars = {},
	border = "rounded",
})
