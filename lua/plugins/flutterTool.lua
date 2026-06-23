local flutter_path = ""

local function is_wsl()
  local output = vim.fn.system("uname -r")
  return output:lower():find("microsoft") ~= nil
end

if vim.fn.has("win32") == 1 then
  -- Windows 原生 Neovim
  flutter_path =
    vim.fn.trim(vim.fn.system([[powershell -Command "& {Get-Command flutter | Select-Object -ExpandProperty Source}"]]))
elseif is_wsl() then
  -- WSL Neovim：调用包装脚本，间接执行 Windows Flutter
  flutter_path = vim.fn.trim(vim.fn.system("which flutter"))
else
  -- Linux / macOS
  flutter_path = vim.fn.trim(vim.fn.system("which flutter"))
end
return {
  {
    "akinsho/flutter-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- optional for vim.ui.select
    },
    init = function()
      vim.api.nvim_create_autocmd("BufWinEnter", {
        group = vim.api.nvim_create_augroup("flutter_dev_log_window", { clear = true }),
        pattern = "__FLUTTER_DEV_LOG__",
        callback = function(ev)
          vim.wo.winfixheight = true
          vim.wo.number = false
          vim.wo.relativenumber = false
          vim.wo.signcolumn = "no"
          vim.wo.foldcolumn = "0"

          vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = ev.buf, silent = true, desc = "Close Flutter log" })
          vim.keymap.set("n", "<Esc>", "<cmd>close<cr>", { buffer = ev.buf, silent = true, desc = "Close Flutter log" })
        end,
      })
    end,
    opts = {
      -- flutter_path = "/usr/bin/flutter",
      -- flutter_path = "/Users/lixinghe/.local/share/flutter/bin/flutter",
      flutter_path = flutter_path,
      ui = {
        border = "rounded",
      },
      decorations = {
        statusline = {
          -- set to true to be able use the 'flutter_tools_decorations.app_version' in your statusline
          -- this will show the current version of the flutter app from the pubspec.yaml file
          app_version = true,
          -- set to true to be able use the 'flutter_tools_decorations.device' in your statusline
          -- this will show the currently running device if an application was started with a specific
          -- device
          device = true,
          -- set to true to be able use the 'flutter_tools_decorations.project_config' in your statusline
          -- this will show the currently selected project configuration
          project_config = false,
        },
      },
      root_patterns = { ".git", "pubspec.yaml" }, -- patterns to find the root of your flutter project
      fvm = false, -- takes priority over path, uses <workspace>/.fvm/flutter_sdk if enabled
      widget_guides = {
        enabled = false,
      },
      closing_tags = {
        highlight = "Comment", -- highlight for the closing tag
        prefix = "//", -- character to use for close tag e.g. > Widget
        enabled = true, -- set to false to disable
      },
      dev_log = {
        enabled = true,
        notify_errors = true,
        open_cmd = "botright 16split",
        focus_on_open = true,
      },
      dev_tools = {
        autostart = false, -- autostart devtools server if not detected
        auto_open_browser = false, -- Automatically opens devtools in the browser
      },
      outline = {
        open_cmd = "30vnew", -- command to use to open the outline buffer
        auto_open = false, -- if true this will open the outline automatically when it is first populated
      },
      lsp = {
        settings = {
          enableSnippets = true,
          showTodos = true,
          completeFunctionCalls = true,
          analysisExcludedFolders = {
            vim.fn.expand("$HOME/.pub-cache"),
            vim.fn.expand("$HOME/fvm"),
          },
          lineLength = vim.g.flutter_format_line_length,
        },
      },
    },
    ft = "dart",
  },
}
