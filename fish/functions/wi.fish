function wi -d "Interactive wrapper for Whitaker's Words"
	echo -n "> "
	while read line
		ww $line
		echo -n "> "
	end
end
