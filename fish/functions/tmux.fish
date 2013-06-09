function tmux -d "Attach to existing tmux session if possible"
	if $argv[1]
		command tmux $argv
	else
		command tmux attach -d &>/dev/null; or command tmux
	end
end
