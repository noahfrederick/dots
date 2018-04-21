function next -d 'Apply "next" tag to task'
	command task $argv[1] modify +next
end

