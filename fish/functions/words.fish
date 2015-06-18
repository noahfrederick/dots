function words --description "Convenience wrapper for Whitaker's Words"
	set -l interactive ''
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
		while read --prompt=_words_prompt query
			set_color normal
			_words_exec $english $query
		end
	else
		_words_exec $english $query
	end
end

function _words_exec
	pushd ~/bin/words >/dev/null
	./words $argv
	popd >/dev/null
end

function _words_prompt
	set_color blue --bold; echo -n "> "
end
