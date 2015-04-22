function today --description "Print today's date with optional offset in days"
	set -l format "+%Y/%m/%d"

	if test (count $argv) -gt 0
		command date -v"$argv[1]"d $format
	else
		command date $format
	end
end
