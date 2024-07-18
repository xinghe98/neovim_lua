local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
require("flutter-tools").setup({
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
		}
	},
	root_patterns = { ".git", "pubspec.yaml" }, -- patterns to find the root of your flutter project
	fvm = false,                             -- takes priority over path, uses <workspace>/.fvm/flutter_sdk if enabled
	widget_guides = {
		enabled = false,
	},
	closing_tags = {
		highlight = "ErrorMsg", -- highlight for the closing tag
		prefix = "//",    -- character to use for close tag e.g. > Widget
		enabled = false   -- set to false to disable
	},
	dev_log = {
		enabled = true,
		notify_errors = false, -- if there is an error whilst running then notify the user
		open_cmd = "tabedit", -- command to use to open the log buffer
	},
	dev_tools = {
		autostart = false,   -- autostart devtools server if not detected
		auto_open_browser = false, -- Automatically opens devtools in the browser
	},
	outline = {
		open_cmd = "30vnew", -- command to use to open the outline buffer
		auto_open = false -- if true this will open the outline automatically when it is first populated
	},
	lsp = {
		on_attach = function()
			vim.cmd('highlight! link FlutterWidgetGuides Comment')
		end,
		capabilities = capabilities,
		settings = {
			enableSnippets = false,
			showTodos = true,
			completeFunctionCalls = true,
			analysisExcludedFolders = {
				vim.fn.expand '$HOME/.pub-cache',
				vim.fn.expand '$HOME/fvm',
			},
			lineLength = vim.g.flutter_format_line_length,
		},
	},
})
