function ww -d "Convenience wrapper for Whitaker's Words"
	pushd ~/bin/words >/dev/null
	./words $argv
	popd >/dev/null
end
