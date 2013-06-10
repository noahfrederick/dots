function abbreviations --description 'List, show and query abbreviations'
	if test (count $argv) = 0
    printf '%s\n' $fish_abbreviations
    return
  end

  set -l abbreviation_index 0
  set -l expanded_abbreviation

  for i in $fish_abbreviations
    set abbreviation_index (math $abbreviation_index + 1)
    echo $i | read -l abbreviation command

    if test $abbreviation = $argv[-1]
      set expanded_abbreviation $command
      break
    end
  end

  if test -n "$expanded_abbreviation"
    switch $argv[1]
      case -q --query
        return 0
      case -e --erase
        set -e fish_abbreviations[$abbreviation_index]
      case '*'
        echo $expanded_abbreviation
      end
  else
    return 1
  end
end
