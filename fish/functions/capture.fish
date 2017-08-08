function capture --description 'Capture a new note in Neovim'
	nvim +"Capture! $argv[1]"
end
