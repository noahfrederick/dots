function prepend_to_path -d "Prepend the given dir to PATH if it exists and is not already listed"
	if test -d "$argv[1]"
		if not contains "$argv[1]" $fish_user_paths
			set --global --prepend fish_user_paths "$argv[1]"
		end
	end
end
