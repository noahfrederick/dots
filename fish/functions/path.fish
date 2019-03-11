function path --description 'Pretty-print PATH'
	for dir in $PATH
		switch $dir
		case '/bin*' '/usr/bin*'
			set_color blue
		case '/sbin*' '/usr/sbin*'
			set_color purple
		case '/local*' '/usr/local*'
			set_color yellow
		case '/opt*'
			set_color cyan
		case '/Users*' '/home*'
			set_color --bold
		case '*'
			set_color normal
		end

		echo $dir
		set_color normal
	end
end
