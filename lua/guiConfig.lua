vim.cmd([[
if exists("g:neovide")
	set guifont=Monaco_Nerd_font:h13
	let g:neovide_transparency = 0.9
	let g:transparency = 0.9
	let g:neovide_background_color = '#0f1117'.printf('%x', float2nr(255 * g:transparency))
endif
]])
