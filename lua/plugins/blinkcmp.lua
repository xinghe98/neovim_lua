return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      preset = "enter",
      ["<CR>"] = { "accept", "fallback" },
      ["<C-e>"] = { "scroll_documentation_down" },
      ["<C-u>"] = { "scroll_documentation_up" },
      ["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
      ["<Down>"] = { "snippet_forward", "select_next" },
      ["<C-n>"] = { "snippet_forward", "select_next" },
      ["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },
      ["<Up>"] = { "snippet_backward", "select_prev" },
      ["<C-p>"] = { "snippet_backward", "select_prev" },
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
      menu = {
        border = "rounded",
        winblend = 0,
        draw = {
          columns = { { "kind_icon" }, { "label", "source_name", "label_description", gap = 1 }, { "kind" } },
          kind_icon = {
            ellipsis = false,
            text = function(ctx)
              return require("lspkind").symbolic(ctx.kind, {
                mode = "symbol",
                symbol_map = {
                  Copilot = "",
                  Text = "󰓽 Text",
                  Method = "m Method",
                  Function = "󰊕 Func",
                  Constructor = " Constructor",
                  Field = " Field",
                  Variable = "󰫧 Variable",
                  Class = " Class",
                  Interface = "󱇰 Interface",
                  Module = " Module",
                  Property = "󰀔 Property",
                  Unit = " Unit",
                  Value = "󱀍 Value",
                  Keyword = "󰌆 Keyword",
                  Snippet = " Snippet",
                  Color = " Color",
                  File = " File",
                  Reference = " Reference",
                  Folder = " Folder",
                  Enum = " Enummember",
                  Constant = " Constant",
                  Struct = "  Struct",
                  Event = " Event",
                  Operator = " Operator",
                  TypeParameter = "󰉺 TypeParameter",
                  Default = "󰊨 default",
                },
              })
            end,
          },
        },
      },
    },
  },
}
