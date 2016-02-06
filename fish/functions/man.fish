function man --description "Read man page with Neovim"
	nvim -c "Man $argv" -c "silent! tabonly"
end
