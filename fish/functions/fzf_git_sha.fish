function fzf_git_sha --description 'Choose git commit SHA from log'
	git graph --color=always \
	| eval (__fzfcmd) --tiebreak=index --no-sort --reverse --ansi --preview "'git show --color=always {+2}'" \
	| cut -d ' ' -f 2 | read -l result
	[ "$result" ]; and commandline -i -- $result
	commandline -f repaint
end
