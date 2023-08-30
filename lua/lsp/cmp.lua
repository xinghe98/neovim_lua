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

local kind_icons = {
	Text = " Text",
	Method = "m Method",
	Function = " Function",
	Constructor = " Constructor",
	Field = " Field",
	Variable = " Variable",
	Class = " Class",
	Interface = " Interface",
	Module = " Module",
	Property = " Property",
	Unit = " Unit",
	Value = " Value",
	Enum = " Enum",
	Keyword = " Keyword",
	Snippet = " snippet",
	Color = " Color",
	File = " File",
	Reference = " Reference",
	Folder = " Folder",
	EnumMember = " EnumMember",
	Constant = " Constant",
	Struct = "  Struct",
	Event = " Event",
	Operator = " Operator",
	TypeParameter = " TypeParameter",
}
local limitStr = function(str)
	if #str > 25 then
		str = string.sub(str, 1, 22) .. "..."
	end
	return str
end
local luasnip = require("luasnip")
local lspkind = require("lspkind")
vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
local cmp = require("cmp")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.register_source("look", require("cmp_look").new())
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
setCompHL()
cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-q>"] = cmp.mapping.abort(),
		-- TODO: potentially fix emmet nonsense
		["<CR>"] = cmp.mapping({
			i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
			c = function(fallback)
				if cmp.visible() then
					cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
				else
					fallback()
				end
			end,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			-- Kind icons
			local kind = string.format("%s", kind_icons[vim_item.kind])
			local strings = vim.split(kind, "%s", { trimempty = true })
			vim_item.kind = " " .. (strings[1] or "") .. " "
			vim_item.menu = "    (" .. (strings[2] or "") .. ")"
			vim_item.menu = ({
				nvim_lsp = "🚀",
				luasnip = "🎯",
				buffer = "📌",
				path = "📬",
				look = "📸",
				spell = "📝",
			})[entry.source.name]
			return vim_item
			--[[ local kind = lspkind.cmp_format({
				mode = "symbol_text",
				symbol_map = { Codeium = "" },
			})(entry, vim_item)
			local strings = vim.split(kind.kind, "%s", { trimempty = true })
			kind.kind = " " .. (strings[1] or "") .. " "
			kind.menu = limitStr(entry:get_completion_item().detail or "")

			return kind ]]
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
vim.diagnostic.config({
	virtual_text = {
		prefix = "😥",
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
cmp.setup.cmdline(":", {
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
})
