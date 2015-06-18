function wi -d "Interactive wrapper for Whitaker's Words"
	while read --prompt=_words_prompt query
		set_color normal
		ww $query
	end
end

function _words_prompt
	set_color blue --bold; echo -n "> "
end
