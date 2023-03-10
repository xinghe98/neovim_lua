vim.cmd("au FileType go nmap <Leader>gd <Plug>(go-doc)")
vim.g.go_doc_keywordprg_enabled    = 0
vim.g.go_echo_go_info = 0
vim.g.go_doc_popup_window = 1
vim.g.go_def_mapping_enabled = 0
vim.g.go_template_autocreate = 0
vim.g.go_textobj_enabled = 0
vim.g.go_auto_type_info = 1
vim.g.go_def_mapping_enabled = 0
vim.g.go_highlight_array_whitespace_error = 1
vim.g.go_highlight_build_constraints = 1
vim.g.go_highlight_chan_whitespace_error = 1
vim.g.go_highlight_extra_types = 1
vim.g.go_highlight_fields = 1
vim.g.go_highlight_format_strings = 1
vim.g.go_highlight_function_calls = 1
vim.g.go_highlight_function_parameters = 1
vim.g.go_highlight_functions = 1
vim.g.go_highlight_generate_tags = 1
vim.g.go_highlight_methods = 1
vim.g.go_highlight_operators = 1
vim.g.go_highlight_space_tab_error = 1
vim.g.go_highlight_string_spellcheck = 1
vim.g.go_highlight_structs = 1
vim.g.go_highlight_trailing_whitespace_error = 1
vim.g.go_highlight_types = 1
vim.g.go_highlight_variable_assignments = 0
vim.g.go_highlight_variable_declarations = 0
vim.cmd([[
augroup go
  autocmd!
  autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
augroup END
]])
