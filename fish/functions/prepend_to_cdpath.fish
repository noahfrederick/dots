function prepend_to_cdpath -d "Prepend the given dir to CDPATH if it exists and is not already listed"
	if test -d "$argv[1]"
		if not contains "$argv[1]" $CDPATH
			set -g CDPATH "$argv[1]" $CDPATH
		end
	end
end
