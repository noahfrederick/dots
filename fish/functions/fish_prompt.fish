function fish_prompt --description 'Write out the prompt'
	if jobs --quiet
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

	# Guard against negative value in certain situations (i.e., in Neovim
	# terminal spawned outside a shell session on GNU/Linux).
	if test $level -lt 1
		set level 1
	end

	string repeat --no-newline --count $level '> '

	set_color normal
end
