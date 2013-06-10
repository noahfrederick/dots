function brew --description 'Default arguments for brew'
	if test (count $argv) -gt 0
		command brew $argv
	else
		command brew update
		and echo -s (set_color --bold blue) '==>' \
			(set_color --bold white) ' Outdated Formulae' (set_color normal)
		and command brew outdated
	end
end
