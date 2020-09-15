function vader --description 'Run Vader tests in Neovim'
	if test (count $argv) -gt 0
		set glob $argv[1]
	else
		set glob 'test/*'
	end
	nvim -c "Vader! $glob" > /dev/null
end
