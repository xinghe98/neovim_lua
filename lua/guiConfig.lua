vim.cmd([[
if exists("g:neovide")
	set guifont=FiraCode_Nerd_Font:h18
	let g:neovide_transparency = 0.0
	let g:transparency = 0.7
	let g:neovide_background_color = '#0f1117'.printf('%x', float2nr(255 * g:transparency))
endif
]])
