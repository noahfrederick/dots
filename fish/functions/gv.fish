function gv --description 'Visualize git log in Neovim'
	nvim +GV +tabonly +'nnoremap <silent> <buffer> q :$wincmd w <bar> quit<cr>'
end
