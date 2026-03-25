return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- 保持获取最新代码
    opts = {
      mode = "agentic",
      -- 默认使用的提供商，指向下面自定义的 minimax
      provider = "minimax",
      -- auto_suggestions_provider = "minimax",
      --
      selector = {
        --- @alias avante.SelectorProvider "native" | "fzf_lua" | "mini_pick" | "snacks" | "telescope" | fun(selector: avante.ui.Selector): nil
        --- @type avante.SelectorProvider
        provider = "snacks",
        -- Options override for custom providers
        provider_opts = {},
      },

      -- 自定义模型配置
      providers = {
        minimax = {
          __inherited_from = "openai",
          endpoint = "https://api.minimaxi.com/v1",
          model = "MiniMax-M2.7",
          api_key_name = "MINMAX_KEY", -- 直接读取环境变量，不需要 cmd:echo
          parse_curl_args = function(opts, code_opts)
            -- 继承 openai 的默认请求参数
            local args = require("avante.providers.openai").parse_curl_args(opts, code_opts)
            -- 可以在这里清洗不需要的参数，但通常 Avante 的 OpenAI 适配器非常干净，不需要额外干预
            return args
          end,
        },
        op = {
          __inherited_from = "openai",
          endpoint = "https://openrouter.ai/api/v1",
          model = "minimax/minimax-m2.7",
          api_key_name = "OPENROUTER_KEY",
          parse_curl_args = function(opts, code_opts)
            local args = require("avante.providers.openai").parse_curl_args(opts, code_opts)
            return args
          end,
        },

        op_glm = {
          __inherited_from = "openai",
          endpoint = "https://openrouter.ai/api/v1",
          model = "z-ai/glm-5",
          api_key_name = "OPENROUTER_KEY",
          parse_curl_args = function(opts, code_opts)
            local args = require("avante.providers.openai").parse_curl_args(opts, code_opts)
            return args
          end,
        },
        deepseek = {
          __inherited_from = "openai",
          endpoint = "https://api.deepseek.com/v1",
          model = "deepseek-chat",
          api_key_name = "DEEPSEEK_KEY",
          parse_curl_args = function(opts, code_opts)
            local args = require("avante.providers.openai").parse_curl_args(opts, code_opts)
            return args
          end,
        },
      },
      behaviour = {
        confirmation_ui_style = "popup", -- 必须确认的弹窗改回悬浮窗
        auto_apply_diff_after_generation = false, -- 代码生成后直接上墙显示 Diff
        auto_suggestions = false, -- 是否开启类似 Copilot 的行内自动补全
        auto_set_highlight_group = true,
        auto_set_keymaps = false,
        support_paste_from_clipboard = true,
        -- 只有文件编辑相关工具需要审批，其他工具自动执行
        auto_approve_tool_permissions = {
          "str_replace",
          "write_to_file",
          "create_file",
          "move_path",
          "copy_path",
          "delete_path",
          "create_dir",
        },
      },
      mappings = {
        diff = {
          next = "}",
          prev = "{",
        },
      },
    },
    keys = {
      -- 打开 Avante 对话 (normal 和 visual 模式)
      { "<Leader>aa", "<cmd>AvanteChat<CR>", desc = "Open Avante", mode = { "n", "v" } },
      { "<Leader>an", "<cmd>AvanteChatNew<CR>", desc = "Open Avante", mode = { "n", "v" } },
      -- Avante 编辑命令 (normal 和 visual 模式)
      { "<Leader>ae", "<cmd>AvanteEdit<CR>", desc = "Avante Edit", mode = { "n", "v" } },
      -- 切换 Help Panel
      { "<Leader>as", "<cmd>AvanteModels<CR>", desc = "Avante model selector" },
      -- 刷新/重新生成响应
      { "<Leader>ar", "<cmd>AvanteRefresh<CR>", desc = "Refresh" },
      -- 聚焦到输入框
      { "<Leader>ak", "<cmd>AvanteFocus<CR>", desc = "Focus Input" },
    },
    -- Windows 下的编译命令。如果你装了 make 也可以用 "make"
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false",
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
      {
        -- 支持直接在对话框粘贴图片给大模型
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            use_absolute_path = true,
          },
        },
      },
      {
        -- 渲染 Markdown 效果，让对话框更好看
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
          -- 美化配置
          render = {
            -- 代码块美化
            code_block = {
              highlight = true,
              line_numbers = true,
              line_number_highlight = "LineNr",
              virtual_text = false,
            },
            -- 列表美化
            list = {
              bullet = "•",
              checkbox = {
                unchecked = "☐",
                checked = "☑",
              },
            },
            -- 表格美化
            table = {
              header_separator = "─",
              column_separator = "│",
              row_separator = "─",
            },
            -- 标题美化
            heading = {
              level_1 = { prefix = "# ", highlight = "Title" },
              level_2 = { prefix = "## ", highlight = "Title" },
              level_3 = { prefix = "### ", highlight = "Title" },
              level_4 = { prefix = "#### ", highlight = "Title" },
              level_5 = { prefix = "##### ", highlight = "Title" },
              level_6 = { prefix = "###### ", highlight = "Title" },
            },
            -- 链接美化
            link = {
              highlight = "Underlined",
              virtual_text = true,
            },
            -- 引用块美化
            blockquote = {
              prefix = "│ ",
              highlight = "Comment",
              indent = 2,
            },
            -- 水平线美化
            horizontal_rule = {
              char = "─",
              highlight = "Comment",
            },
          },
          -- 语法高亮主题
          highlight = {
            theme = "everforest", -- 匹配当前主题
            background = "none", -- 透明背景
          },
          -- 动画效果
          animations = {
            enabled = true,
            fade_in_speed = 10,
            fade_out_speed = 10,
          },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
}
