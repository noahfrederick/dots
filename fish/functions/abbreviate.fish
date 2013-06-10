function abbreviate --description 'Define a new abbreviation'
	if test (count $argv) -lt 2
    echo 'abbreviate: Takes two arguments. First abbreviation and then expanded command'
    return 1
  end

  echo $argv | read -l abbreviation command

  eval "function $abbreviation; $command \$argv; end"
  abbreviations -e $abbreviation

  set -U fish_abbreviations $fish_abbreviations "$argv"
  return 0
end
