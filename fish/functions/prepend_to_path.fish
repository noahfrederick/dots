function prepend_to_path -d "Prepend the given dir to PATH if it exists and is not already listed"
	if test -d "$argv[1]"
		if not contains "$argv[1]" $PATH
			set -x PATH "$argv[1]" $PATH
		end
	end
end
