function tmux -d "Attach to existing tmux session if possible"
	if test (count $argv) -gt 0
		command tmux $argv
	else
		command tmux attach-session -d >/dev/null ^&1
		or command tmux
	end
end
