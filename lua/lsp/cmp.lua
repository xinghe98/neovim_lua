local setCompHL = function()
	local fgdark = "#2E3440"

	vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#82AAFF", bg = "NONE", bold = true })
	vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#82AAFF", bg = "NONE", bold = true })
	vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = "#7E8294", bg = "NONE", strikethrough = true })

	vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#808080", bg = "NONE", italic = true })
	vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = fgdark, bg = "#B5585F" })
	vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = fgdark, bg = "#B5585F" })
	vim.api.nvim_set_hl(0, "CmpItemKindEvent", { fg = fgdark, bg = "#B5585F" })

	vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = fgdark, bg = "#9FBD73" })
	vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = fgdark, bg = "#9FBD73" })
	vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = fgdark, bg = "#9FBD73" })

	vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = fgdark, bg = "#D4BB6C" })
	vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = fgdark, bg = "#D4BB6C" })
	vim.api.nvim_set_hl(0, "CmpItemKindReference", { fg = fgdark, bg = "#D4BB6C" })

	vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = fgdark, bg = "#A377BF" })
	vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = fgdark, bg = "#A377BF" })
	vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = fgdark, bg = "#A377BF" })
	vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = fgdark, bg = "#A377BF" })
	vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = fgdark, bg = "#A377BF" })

	vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = fgdark, bg = "#7E8294" })
	vim.api.nvim_set_hl(0, "CmpItemKindFile", { fg = fgdark, bg = "#7E8294" })

	vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = fgdark, bg = "#D4A959" })
	vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = fgdark, bg = "#D4A959" })
	vim.api.nvim_set_hl(0, "CmpItemKindFolder", { fg = fgdark, bg = "#D4A959" })

	vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = fgdark, bg = "#6C8ED4" })
	vim.api.nvim_set_hl(0, "CmpItemKindValue", { fg = fgdark, bg = "#6C8ED4" })
	vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { fg = fgdark, bg = "#6C8ED4" })

	vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = fgdark, bg = "#58B5A8" })
	vim.api.nvim_set_hl(0, "CmpItemKindColor", { fg = fgdark, bg = "#58B5A8" })
	vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = fgdark, bg = "#58B5A8" })
end

--[[ local source_icons = {
	nvim_lsp = "🚀",
	luasnip = "🎯",
	buffer = "📌",
	path = "📬",
	look = "📸",
	spell = "📝",
	calc = "[calc]",
} ]]

local source_icons = {}
-- mac下emoji表情真丑，以前都没发现
if vim.fn.has("mac") == 1 then
	source_icons = {
		nvim_lsp = "  [lsp]",
		luasnip = "  [luasnip]",
		buffer = "  [buffer]",
		path = "  [path]",
		look = "  [look]",
		spell = "  [spell]",
		calc = "  [calc]",
	}
else
	source_icons = {
		nvim_lsp = "🚀",
		luasnip = "🎯",
		buffer = "📌",
		path = "📬",
		look = "📸",
		spell = "📝",
		calc = "[calc]",
	}
end

require("lspkind").init({
	symbol_map = {
		text = "󰓽 Text",
		method = "m Method",
		Function = "󰊕 Func",
		constructor = " Constructor",
		field = " Field",
		variable = "󱄑 Variable",
		class = " Class",
		interface = " Interface",
		module = " Module",
		property = "󰀔 Property",
		unit = " Unit",
		value = "󱀍 Value",
		keyword = "󰌆 Keyword",
		snippet = " Snippet",
		color = " Color",
		file = " File",
		reference = " Reference",
		folder = " Folder",
		enum = " Enummember",
		constant = " Constant",
		struct = "  Struct",
		event = " Event",
		operator = " Operator",
		typeParameter = "󰉺 TypeParameter",
		default = "󰊨 default",
	},
})

local limitStr = function(str)
	if #str > 25 then
		str = string.sub(str, 1, 22) .. "..."
	end
	return str
end
--- 解决补全: ,时鼠标光标在,后面的问题
--[[ local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end ]]
local moveCursorBeforeComma = function()
	if vim.bo.filetype ~= "dart" then
		return
	end
	vim.defer_fn(function()
		local line = vim.api.nvim_get_current_line()
		local row, col = unpack(vim.api.nvim_win_get_cursor(0))
		local char = line:sub(col - 2, col)
		if char == ": ," then
			vim.api.nvim_win_set_cursor(0, { row, col - 1 })
		end
	end, 60)
end
--- end ----
local dartColonFirst = function(entry1, entry2)
	--[[ if vim.bo.filetype ~= "dart" then
		return nil
	end ]]
	local entry1EndsWithColon = string.find(entry1.completion_item.label, ":") and entry1.source.name == "nvim_lsp"
	local entry2EndsWithColon = string.find(entry2.completion_item.label, ":") and entry2.source.name == "nvim_lsp"
	if entry1EndsWithColon and not entry2EndsWithColon then
		return true
	elseif not entry1EndsWithColon and entry2EndsWithColon then
		return false
	end
	return nil
end

local luasnip = require("luasnip")
vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
local cmp = require("cmp")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
cmp.register_source("look", require("cmp_look").new())
setCompHL()
cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		--[[ completion = {
			-- winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
			col_offset = -3,
			side_padding = 0,
		}, ]]
		documentation = cmp.config.window.bordered(),
	},
	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Insert,
		select = false,
	},
	completion = { completeopt = "noselect", keyword_length = 1 },
	preselect = cmp.PreselectMode.none,
	mapping = cmp.mapping.preset.insert({
		--[[ ["<C-u>"] = cmp.mapping.select_prev_item(),
		["<C-e>"] = cmp.mapping.select_next_item(), ]]
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-e>"] = cmp.mapping.scroll_docs(4),
		["<C-q>"] = cmp.mapping.abort(),
		-- ["<Esc>"] = cmp.mapping.abort(),
		-- TODO: potentially fix emmet nonsense
		["<CR>"] = cmp.mapping({
			i = function(fallback)
				if cmp.visible() then
					cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })
					moveCursorBeforeComma()
				else
					fallback()
				end
			end,
			--[[ c = function(fallback)
				if cmp.visible() then
					cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = false })
					moveCursorBeforeComma()
				elseif has_words_before() then
					cmp.complete()
					moveCursorBeforeComma()
				else
					fallback()
				end
			end, ]]
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	--[[ formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
			local strings = vim.split(kind.kind, "%s", { trimempty = true })
			kind.kind = " " .. (strings[1] or "") .. " "
			kind.menu = "    (" .. (strings[2] or "") .. ")"

			return kind
		end,
	}, ]]
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			-- Kind icons
			local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
			local strings = vim.split(kind.kind, "%s", { trimempty = true })
			vim_item.kind = " " .. (strings[1] or "") .. " "
			-- local name = entry.source.name
			if entry:get_completion_item().detail ~= nil then
				vim_item.menu = " "
					.. (strings[2] or "")
					.. ":"
					.. " "
					.. limitStr(entry:get_completion_item().detail or "")
			else
				vim_item.menu = " " .. (strings[2] or "")
			end
			return vim_item
		end,
	},
	sorting = {
		comparators = {
			-- label_comparator,
			dartColonFirst,
			cmp.config.compare.offset,
			cmp.config.compare.exact,
			cmp.config.compare.score,
			cmp.config.compare.recently_used,
			cmp.config.compare.kind,
		},
	},
	sources = {
		{ name = "nvim_lsp", keyword_length = 2, priority = 100 },
		{ name = "buffer", keyword_length = 3, priority = 60 },
		{ name = "path", keyword_length = 3, priority = 90 },
		{ name = "nvim_lua", keyword_length = 3, priority = 50 },
		{ name = "look", keyword_length = 3, priority = 40 },
		{
			name = "spell",
			option = {
				keyword_length = 4,
				keep_all_entries = true,
				enable_in_context = function()
					return true
				end,
			},
			priority = 40,
		},
		{ name = "luasnip", keyword_length = 3, priority = 10 },
		{ name = "calc", priority = 5 },
	},
})
-- Set configuration for specific filetype.
cmp.setup.filetype("gitcommit", {
	sources = cmp.config.sources({
		{ name = "git" }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
	}, {
		{ name = "buffer" },
	}),
})
--[[ cmp.event:on("menu_opened", function()
	vim.defer_fn(function()
		if _LSP_SIG_CFG.winnr ~= nil and _LSP_SIG_CFG.winnr ~= 0 and vim.api.nvim_win_is_valid(_LSP_SIG_CFG.winnr) then
			vim.api.nvim_win_close(_LSP_SIG_CFG.winnr, true)
			_LSP_SIG_CFG.winnr = nil
			_LSP_SIG_CFG.bufnr = nil
		end
	end, 60)
end) ]]

--[[ cmp.event:on("complete_done", function()
	vim.defer_fn(function()
		if
			not (
				_LSP_SIG_CFG.winnr ~= nil
				and _LSP_SIG_CFG.winnr ~= 0
				and vim.api.nvim_win_is_valid(_LSP_SIG_CFG.winnr)
			)
		then
			require("lsp_signature").toggle_float_win()
		end
	end, 60)
end) ]]
-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
--[[ cmp.setup.cmdline({ '/', '?' }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{
			name = 'buffer',
			keyword_length = 3
		}
	}
}) ]]

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
--[[ cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{
			name = "path",
			keyword_length = 3,
		},
	}, {
		{
			name = "cmdline",
			keyword_length = 3,
		},
	}),
}) ]]
