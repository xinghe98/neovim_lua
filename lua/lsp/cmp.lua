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
local luasnip = require 'luasnip'

local cmp = require 'cmp'
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
	'confirm_done',
	cmp_autopairs.on_confirm_done()
)

cmp.setup {
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
		['<CR>'] = cmp.mapping({
			i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
			c = function(fallback)
				if cmp.visible() then
					cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
				else
					fallback()
				end
			end
		}),
		['<Tab>'] = cmp.mapping(function(fallback)

			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { 'i', 's' }),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { 'i', 's' }),
	}),
	formatting = {
		fields = { "abbr", "kind", "menu" },
		format = function(entry, vim_item)
			-- Kind icons
			vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
			vim_item.menu = ({
				nvim_lsp = "[LSP]",
				ultisnips = "[Snippet]",
				buffer = "[Buffer]",
				path = "[Path]",
				look = "[Look]",
				spell = "[Spell]",
			})[entry.source.name]
			return vim_item
		end,
	},
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
		{ name = 'buffer' },
		{ name = 'path' },
		{ name = 'nvim_lua' },
		{ name = 'look' },
		{ name = 'spell' },
		{ name = 'nvim_lsp_signature_help' },
	},
}
vim.diagnostic.config({
	virtual_text = {
		prefix = '●',
	},
})
