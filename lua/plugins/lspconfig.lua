return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "dart" } },
  },
  -- LSP keymaps
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- change a keymap
      keys[#keys + 1] = {
        "gd",
        function()
          Snacks.picker.lsp_definitions()
        end,
        desc = "跳转到定义",
      }
      keys[#keys + 1] = {
        "gr",
        function()
          Snacks.picker.lsp_references()
        end,
        nowait = true,
        desc = "跳转到引用",
      }
      keys[#keys + 1] = {
        "gi",
        function()
          Snacks.picker.lsp_implementations()
        end,
        desc = "跳转到实现",
      }
      keys[#keys + 1] = {
        "<leader>gg",
        function()
          Snacks.picker.diagnostics()
        end,
        desc = "查看所有诊断",
      }
      keys[#keys + 1] = { "gh", "<cmd>Lspsaga hover_doc<CR>", desc = "查看帮助文档" }
      -- keys[#keys + 1] = { "<M-a>", ":Lspsaga code_action<CR>" }
      keys[#keys + 1] = { "<M-a>", ":lua vim.lsp.buf.code_action()<CR>" }
      -- keys[#keys + 1] ={ "<M-A>", "<cmd>lua require('lspsaga.codeaction'):code_action({ context = { only = { 'source' } }})<CR>" }
      keys[#keys + 1] =
        { "<M-A>", ":lua vim.lsp.buf.code_action({ context = {only = { 'source' },diagnostics = {}}})<CR>" }
      keys[#keys + 1] = { "<leader>rn", vim.lsp.buf.rename, desc = "重命名变量", has = "rename" }
      keys[#keys + 1] = { "<C-e>", ":Lspsaga diagnostic_jump_next<CR>", desc = "下一个诊断" }
      keys[#keys + 1] = { "<C-u>", ":Lspsaga diagnostic_jump_prev<CR>", desc = "上一个诊断" }
      keys[#keys + 1] = { "<leader>ge", ":Lspsaga show_line_diagnostics<CR>", desc = "查看详细的错误信息" }
      -- -- disable a keymap
      keys[#keys + 1] = { "<leader>cr", false }
      keys[#keys + 1] = { "gI", false }
      keys[#keys + 1] = { "K", false }
      -- add a keymap
      -- keys[#keys + 1] = { "H", "<cmd>echo 'hello'<cr>" }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- options for vim.diagnostic.config()
      ---@type vim.diagnostic.Opts
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "󰞏 ",
          -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
          -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
          -- prefix = "icons",
        },
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = LazyVim.config.icons.diagnostics.Error,
            [vim.diagnostic.severity.WARN] = LazyVim.config.icons.diagnostics.Warn,
            [vim.diagnostic.severity.HINT] = LazyVim.config.icons.diagnostics.Hint,
            [vim.diagnostic.severity.INFO] = LazyVim.config.icons.diagnostics.Info,
          },
        },
      },
      -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
      -- Be aware that you also will need to properly configure your LSP server to
      -- provide the inlay hints.
      inlay_hints = {
        enabled = true,
        exclude = { "vue" }, -- filetypes for which you don't want to enable inlay hints
      },
      -- Enable this to enable the builtin LSP code lenses on Neovim >= 0.10.0
      -- Be aware that you also will need to properly configure your LSP server to
      -- provide the code lenses.
      codelens = {
        enabled = false,
      },
      -- Enable lsp cursor word highlighting
      document_highlight = {
        enabled = true,
      },
      -- add any global capabilities here
      capabilities = {
        workspace = {
          fileOperations = {
            didRename = true,
            willRename = true,
          },
        },
      },
      -- options for vim.lsp.buf.format
      -- `bufnr` and `filter` is handled by the LazyVim formatter,
      -- but can be also overridden when specified
      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },
      -- LSP Server Settings
      ---@type lspconfig.options
      servers = {
        marksman = {}, -- 确保 marksman 不报中文错误
        lua_ls = {
          -- mason = false, -- set to false if you don't want this server to be installed with mason
          -- Use this to add any additional keymaps
          -- for specific lsp servers
          -- ---@type LazyKeysSpec[]
          -- keys = {},
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              codeLens = {
                enable = true,
              },
              completion = {
                callSnippet = "Replace",
              },
              doc = {
                privateName = { "^_" },
              },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Enable",
              },
            },
          },
        },

        -- emmet_language_server = {},
        volar = {
          -- explicitly add default filetypes, so that we can extend
          -- them in related extras
          filetypes = {
            -- "javascriptreact",
            -- "javascript.jsx",
            -- "typescriptreact",
            -- "typescript.tsx",
            "vue",
          },
          init_options = {
            vue = {
              hybridMode = true,
            },
          },
          settings = {},
        },
        vtsls = {
          -- explicitly add default filetypes, so that we can extend
          -- them in related extras
          filetypes = {
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx",
            "vue",
          },
          settings = {
            complete_function_calls = true,
            vtsls = {
              enableMoveToFileCodeAction = true,
              autoUseWorkspaceTsdk = true,
              experimental = {
                completion = {
                  enableServerSideFuzzyMatch = true,
                },
              },
            },
            typescript = {
              updateImportsOnFileMove = { enabled = "always" },
              suggest = {
                completeFunctionCalls = true,
              },
              inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                parameterNames = { enabled = "literals" },
                parameterTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = true },
              },
            },
          },
        },
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- example to setup with typescript.nvim
        -- tsserver = function(_, opts)
        --   require("typescript").setup({ server = opts })
        --   return true
        -- end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
  },
}
