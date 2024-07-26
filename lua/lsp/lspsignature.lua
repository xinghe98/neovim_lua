local signature = require("lsp_signature")
signature.setup({
	bind = true,
	focusable = false,
	floating_window = true,
	floating_window_above_cur_line = true,
	hint_enable = true,
	always_trigger = false,
	check_completion_visible = true,
	hint_inline = function()
		return false
	end, -- should the hint be inline(nvim 0.10 only)?  default false
	-- return true | 'inline' to show hint inline, return 'eol' to show hint at end of line, return false to disable
	-- return 'right_align' to display hint right aligned in the current line
	fix_pos = true,
	-- floating_window_above_first = true,
	hi_parameter = "Search",
	zindex = 200,
	timer_interval = 100,
	hint_prefix = "🦊", -- Panda for parameter
	hint_scheme = "String",
	extra_trigger_chars = {},
	handler_opts = {
		border = "rounded",
	},
})
local function escape_term_codes(str)
	return vim.api.nvim_replace_termcodes(str, true, false, true)
end

local function is_float_open(window_id)
	return window_id and window_id ~= 0 and vim.api.nvim_win_is_valid(window_id)
end

local function scroll_float(mapping)
	local win_id = _G._LSP_SIG_CFG.winnr

	if is_float_open(win_id) then
		vim.fn.win_execute(win_id, ":normal! " .. mapping)
	end
end

local scroll_up_mapping = escape_term_codes("<c-u>")
local scroll_down_mapping = escape_term_codes("<c-e>")
vim.keymap.set("i", "<c-u>", function()
	scroll_float(scroll_up_mapping)
end, {})
vim.keymap.set("i", "<c-e>", function()
	scroll_float(scroll_down_mapping)
end, {})
