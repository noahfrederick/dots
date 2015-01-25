function mux -d "Enhanced tmuxinator with fuzzy completion menu"
	if test (count $argv) -gt 0
		tmuxinator $argv
	else
		# This would be cleaner with command substitution, but interactive
		# commands get backgrounded. See discussion of this bug:
		# https://github.com/fish-shell/fish-shell/issues/1362
		tmuxinator completions start | fzf --select-1 --exit-0 | xargs tmuxinator start
	end
end
