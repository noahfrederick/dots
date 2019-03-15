function fish_prompt --description 'Write out the prompt'
	if jobs > /dev/null
		set_color green --bold
	else
		set_color brgrey --bold
	end

	set -l level $SHLVL

	if test -n "$TMUX"
		set level (math $level - 2) # fish -> tmux -> fish
	end

	if test -n "$NVIM_LISTEN_ADDRESS"
		set level (math $level - 2) # nvim -> 'shell' -> fish
	end

	string repeat --no-newline --count $level '> '

	set_color normal
end
