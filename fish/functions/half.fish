function half --description 'Divide a number by 2 with default precision of 2'
	set -l include_remainder
	set -l precision 2

	if test (count $argv) -gt 1
		set include_remainder 1
	end

	if test (count $argv) -gt 2
		set precision $argv[3]
	end

	if test -z $include_remainder
		echo "scale = $precision; $argv[1] / 2" | bc
	else
		echo "scale = $precision; ($argv[1] / 2) + ($argv[1] % 2)" | bc
	end
end
