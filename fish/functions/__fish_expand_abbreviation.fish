function __fish_expand_abbreviation
	if test (count (commandline -poc)) -eq 0
    set -l token (commandline -t)

    if abbreviations -q $token
      commandline -t (abbreviations $token)
    end
  end
end
