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
	completion = { completeopt = "noselect" },
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
			i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
			c = function(fallback)
				if cmp.visible() then
					cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })
				else
					fallback()
				end
			end,
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
			if entry.source.name ~= nil then
				vim_item.menu = "   " .. (strings[2] or "") .. " "
			else
				vim_item.menu = "   " .. (strings[2] or "") .. " "
			end
			return vim_item
		end,
	},
	sources = {
		{ name = "nvim_lsp", keyword_length = 2 },
		{ name = "buffer", keyword_length = 3 },
		{ name = "path", keyword_length = 3 },
		{ name = "nvim_lua", keyword_length = 3 },
		{ name = "look", keyword_length = 3 },
		{
			name = "spell",
			option = {
				keyword_length = 3,
				keep_all_entries = true,
				enable_in_context = function()
					return true
				end,
			},
		},
		{ name = "luasnip", keyword_length = 3 },
		{ name = "calc" },
		-- { name = 'nvim_lsp_signature_help' },
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
