function vim --description 'Vim with default arguments'
	if test (count $argv) -gt 0
		command vim $argv
	else if test -r Session.vim
		command vim -S
	else
		command vim .
	end
end
