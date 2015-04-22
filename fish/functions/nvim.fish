function nvim --description 'Neovim with default arguments'
	if test (count $argv) -gt 0
		command nvim $argv
	else if test -r Session.vim
		command nvim -S
	else
		command nvim
	end
end
