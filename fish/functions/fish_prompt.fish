function fish_prompt --description 'Write out the prompt'
	if jobs > /dev/null
		set_color green --bold
	else
		set_color brgrey --bold
	end

	set -l level $SHLVL

	if test -n "$TMUX"
		set level (math $SHLVL - 2) # fish -> tmux -> fish
	end

	string repeat --no-newline --count $level '> '

	set_color normal
end
