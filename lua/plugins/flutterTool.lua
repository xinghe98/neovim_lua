local flutter_path = ""
local dart_path = ""

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
  dart_path = "/home/xinghe/flutter-bin/flutter/bin/dart"
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
        enabled = false,
        notify_errors = false, -- if there is an error whilst running then notify the user
        open_cmd = "tabnew",
        focus_on_open = false,
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
        cmd = {
          dart_path,
          "language-server",
          "--protocol=lsp",
        },
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
