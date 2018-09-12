function gva --description 'Visualize git log in Neovim'
	nvim +'GV --all' +tabonly +'nnoremap <silent> <buffer> q :$wincmd w <bar> quit<cr>'
end
