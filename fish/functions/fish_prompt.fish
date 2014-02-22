set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_showuntrackedfiles ""

set -g __fish_git_prompt_color_branch magenta bold
set -g __fish_git_prompt_showupstream "informative"
set -g __fish_git_prompt_char_upstream_ahead "↑"
set -g __fish_git_prompt_char_upstream_behind "↓"
set -g __fish_git_prompt_char_upstream_prefix " "

set -g __fish_git_prompt_char_stagedstate "+"
set -g __fish_git_prompt_char_dirtystate "●"
set -g __fish_git_prompt_char_untrackedfiles "…"
set -g __fish_git_prompt_char_conflictedstate "x"
set -g __fish_git_prompt_char_cleanstate ""
set -g __fish_git_prompt_char_stateseparator " "

set -g __fish_git_prompt_color_dirtystate blue
set -g __fish_git_prompt_color_stagedstate green
set -g __fish_git_prompt_color_invalidstate red
set -g __fish_git_prompt_color_untrackedfiles red
set -g __fish_git_prompt_color_cleanstate green --bold
set -g __fish_git_prompt_color_upstream magenta

function fish_prompt --description 'Write out the prompt'
	set -l last_status $status

	if not test $last_status -eq 0
		set_color $fish_color_error
	else
		set_color green --bold
	end

	echo -n '> '

	# PWD
	set_color $fish_color_cwd
	echo -n (prompt_pwd)
	set_color normal

	printf '%s ' (__fish_git_prompt ' %s')
end
