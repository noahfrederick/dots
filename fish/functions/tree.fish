function tree -d "Default flags for tree"
	command tree -Ca -I '.svn|.git' --dirsfirst $argv
end
