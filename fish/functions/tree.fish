function tree -d "Default flags for tree"
	command tree -Ca -I '.svn|.git|node_modules|vendor' --dirsfirst $argv
end
