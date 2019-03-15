function words --description "Convenience wrapper for Whitaker's Words"
	set -l interactive
	set -l english
	set -l query

	for arg in $argv
		switch $arg
			case --english -e
				set english '~e'
			case --interactive -i
				set interactive 1
			case '*'
				set query $query $arg
		end
	end

	if test -n $interactive
		while read --prompt=__words_prompt query
			set_color normal
			__words_exec $english $query
		end
	else
		__words_exec $english $query
	end
end

function __words_exec
	pushd ~/.local/bin/words >/dev/null
	./words $argv
	popd >/dev/null
end

function __words_prompt
	set_color blue --bold; echo -n '> '
end
