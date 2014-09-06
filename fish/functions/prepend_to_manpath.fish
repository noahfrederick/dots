function prepend_to_manpath -d "Prepend the given dir to PATH if it exists and is not already listed"
	if test -d "$argv[1]"
		if not contains "$argv[1]" $MANPATH
			set -gx MANPATH "$argv[1]":$MANPATH
		end
	end
end
