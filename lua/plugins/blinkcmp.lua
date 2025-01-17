local setCompHL = function()
  vim.api.nvim_set_hl(0, "BlinkCmpLabelMatch", { fg = "#82AAFF", bg = "NONE", bold = true })
  vim.api.nvim_set_hl(0, "BlinkCmpLabel", { fg = "#7E8294", bg = "NONE" })
  vim.api.nvim_set_hl(0, "BlinkCmpKind", { fg = "#7e8294" })
  vim.api.nvim_set_hl(0, "BlinkCmpMenu", { fg = "#808080", bg = "NONE" })

  vim.api.nvim_set_hl(0, "BlinkCmpKindField", { fg = "#B5585F" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindProperty", { fg = "#B5585F" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindEvent", { fg = "#B5585F" })

  vim.api.nvim_set_hl(0, "BlinkCmpKindText", { fg = "#9FBD73" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindEnum", { fg = "#9FBD73" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindKeyword", { fg = "#9FBD73" })

  vim.api.nvim_set_hl(0, "BlinkCmpKindConstant", { fg = "#D4BB6C" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindConstructor", { fg = "#D4BB6C" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindReference", { fg = "#D4BB6C" })

  vim.api.nvim_set_hl(0, "BlinkCmpKindFunction", { fg = "#A377BF" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindStruct", { fg = "#A377BF" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindClass", { fg = "#A377BF" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindModule", { fg = "#A377BF" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindOperator", { fg = "#A377BF" })

  vim.api.nvim_set_hl(0, "BlinkCmpKindVariable", { fg = "#58B5A8" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindFile", { fg = "#58B5A8" })

  vim.api.nvim_set_hl(0, "BlinkCmpKindUnit", { fg = "#D4A959" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindSnippet", { fg = "#D4A959" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindFolder", { fg = "#D4A959" })

  vim.api.nvim_set_hl(0, "BlinkCmpKindMethod", { fg = "#6C8ED4" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindValue", { fg = "#6C8ED4" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindEnumMember", { fg = "#6C8ED4" })

  vim.api.nvim_set_hl(0, "BlinkCmpKindInterface", { fg = "#58B5A8" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindColor", { fg = "#58B5A8" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindTypeParameter", { fg = "#58B5A8" })
end
setCompHL()
return {
  "saghen/blink.cmp",

  dependencies = {
    { "onsails/lspkind.nvim" },
  },
  opts = {
    keymap = {
      preset = "enter",
      ["<CR>"] = { "accept", "fallback" },
      ["<C-e>"] = { "scroll_documentation_down" },
      ["<C-u>"] = { "scroll_documentation_up" },
      ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
      ["<Down>"] = { "snippet_forward", "select_next" },
      ["<C-n>"] = { "snippet_forward", "select_next" },
      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      ["<Up>"] = { "snippet_backward", "select_prev" },
      ["<C-p>"] = { "snippet_backward", "select_prev" },
      ["<ESC>"] = { "cancel", "fallback" },
    },
    appearance = {
      -- Sets the fallback highlight groups to nvim-cmp's highlight groups
      -- Useful for when your theme doesn't support blink.cmp
      -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = "mono",
    },
    signature = {
      enabled = true,
      trigger = {
        blocked_trigger_characters = {},
        blocked_retrigger_characters = {},
        -- When true, will show the signature help window when the cursor comes after a trigger character when entering insert mode
        show_on_insert_on_trigger_character = true,
      },
      window = {
        min_width = 1,
        max_width = 100,
        max_height = 10,
        border = "rounded",
        winblend = 0,
        winhighlight = "Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder",
        scrollbar = false, -- Note that the gutter will be disabled when border ~= 'none'
        -- Which directions to show the window,
        -- falling back to the next direction when there's not enough space,
        -- or another window is in the way
        direction_priority = { "n", "s" },
        -- Disable if you run into performance issues
        treesitter_highlighting = true,
      },
    },
    completion = {
      trigger = {
        show_on_insert_on_trigger_character = false,
      },
      documentation = {
        auto_show = true,
        window = {
          border = "rounded",
          direction_priority = {
            menu_north = { "w", "e", "n", "s" },
            menu_south = { "w", "e", "s", "n" },
          },
        },
      },
      list = {
        -- Maximum number of items to display
        max_items = 200,
        -- Controls if completion items will be selected automatically,
        -- and whether selection automatically inserts
        selection = { preselect = false, auto_insert = false },
        -- Controls how the completion items are selected
        -- 'preselect' will automatically select the first item in the completion list
        -- 'manual' will not select any item by default
        -- 'auto_insert' will not select any item by default, and insert the completion items automatically
        -- when selecting them
        --
        -- You may want to bind a key to the `cancel` command, which will undo the selection
        -- when using 'auto_insert'
        cycle = {
          -- When `true`, calling `select_next` at the *bottom* of the completion list
          -- will select the *first* completion item.
          from_bottom = true,
          -- When `true`, calling `select_prev` at the *top* of the completion list
          -- will select the *last* completion item.
          from_top = true,
        },
      },
      menu = {
        border = "rounded",
        winblend = 0,
        winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
        draw = {
          treesitter = { "lsp" },
          columns = { { "kind_icon" }, { "label", "label_description", "source_name", gap = 1 }, { "kind" } },
          components = {
            label = {
              ellipsis = true,
              width = { fill = true, max = 50 },
              text = function(ctx)
                return ctx.label .. ctx.label_detail
              end,
              highlight = function(ctx)
                local highlights = {
                  {
                    0,
                    #ctx.label,
                    group = ctx.deprecated and "BlinkCmpLabelDeprecated" or "BlinkCmpLabel",
                  },
                }
                if ctx.label_detail then
                  table.insert(
                    highlights,
                    { #ctx.label, #ctx.label + #ctx.label_detail, group = "BlinkCmpLabelDetail" }
                  )
                end
                for _, idx in ipairs(ctx.label_matched_indices) do
                  table.insert(highlights, { idx, idx + 1, group = "BlinkCmpLabelMatch" })
                end
                return highlights
              end,
            },
            source_name = {
              width = { max = 30 },
              -- source_name or source_id are supported
              text = function(ctx)
                return ({
                  LSP = "🎮",
                  Snippets = "🛟",
                  Buffer = "💊",
                  Path = "📂",
                })[ctx.source_name]
              end,
            },
            kind = {
              text = function(ctx)
                return "<" .. ctx.kind .. ">"
              end,
              highlight = function(ctx)
                return require("blink.cmp.completion.windows.render.tailwind").get_hl(ctx) or "BlinkCmpLabel"
              end,
            },
            kind_icon = {
              ellipsis = false,
              text = function(ctx)
                require("lspkind").init({
                  mode = "symbol",
                  symbol_map = {
                    Text = "󰓽",
                    Method = "m",
                    Function = "󰊕",
                    Constructor = " ",
                    Field = " ",
                    Variable = "󰫧 ",
                    Class = " ",
                    Interface = "󱇰 ",
                    Module = " ",
                    Property = "󰀔 ",
                    Unit = " ",
                    Value = "󱀍 ",
                    Keyword = "󰌆",
                    Snippet = "󰩫",
                    Color = " ",
                    File = " ",
                    Reference = " ",
                    Folder = " ",
                    Enum = " ",
                    Constant = " ",
                    Struct = "  ",
                    Event = " ",
                    Operator = " ",
                    TypeParameter = "󰉺 ",
                    Default = "󰊨 ",
                  },
                })
                return require("lspkind").symbolic(ctx.kind, {
                  mode = "symbol",
                })
              end,
            },
          },
        },
      },
    },
  },
}
