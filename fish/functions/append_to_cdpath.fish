function append_to_cdpath -d "Append the given dir to CDPATH if it exists and is not already listed"
	if test -d "$argv[1]"
		if not contains "$argv[1]" $CDPATH
			set -g CDPATH $CDPATH "$argv[1]"
		end
	end
end
