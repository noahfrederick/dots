# If not running interactively, don't do anything
[ -z "$PS1" ] && return


# TERM --------------------------------------------------------------

case "$TERM" in
	xterm*) TERM=xterm-256color
esac


# ALIASES -----------------------------------------------------------

# Recursive ls piped through less
alias lr='ls -lR | less'

# Easy editing of config files
alias nanorc="$EDITOR ~/.nanorc"
alias bashrc="$EDITOR ~/.bashrc"
alias vimrc="$EDITOR ~/.vimrc"


# FUNCTIONS ---------------------------------------------------------

# Give visual indicator of exit status of previous command.
result () {
	if [ $? = 0 ]; then
		echo -e "\033[0;32m----- Success -----\033[0m"
	else
		echo -e "\033[0;33m----- Failure -----\033[0m"
	fi
}


# PROMPT ------------------------------------------------------------

# Source script that defines __git_ps1 ()
if [ -f ~/bin/git-completion.bash ] ; then
	source ~/bin/git-completion.bash
	
	# Show a "*" next to branch name for unstaged changes, a "+"
	# for staged changes, and a "$" for stashed changes.
	GIT_PS1_SHOWDIRTYSTATE=1
	GIT_PS1_SHOWSTASHSTATE=1
fi

# Shorten long PWD
__shortw ()
{
    local PRE= NAME="$1" LENGTH="$2"
    [[ "$NAME" != "${NAME#$HOME/}" || -z "${NAME#$HOME}" ]] &&
        PRE+='~' NAME="${NAME#$HOME}" LENGTH=$[LENGTH-1];
    ((${#NAME}>$LENGTH)) && NAME="/...${NAME:$[${#NAME}-LENGTH+4]}";
    echo "$PRE$NAME"
}

COLOR_BOLD="\[\e[1m\]"
COLOR_DEFAULT="\[\e[0m\]"
COLOR_BLACK="\[\e[30m\]"

# user@host cwd (gitbranch) $
PS1="$COLOR_BOLD"'\u@\h $(__shortw "$PWD" 25)$(__git_ps1)'" \$ $COLOR_DEFAULT"
PS2="$COLOR_BOLD > $COLOR_DEFAULT"


# HISTORY and BOOKMARKS ---------------------------------------------

# Don't put duplicate lines in the history. See bash(1) for more options.
export HISTCONTROL=ignoredups

# Bookmark directories.
if [ -f ~/bin/bmark.sh ] ; then
	source ~/bin/bmark.sh
fi


# TMUXINATOR --------------------------------------------------------

[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator


# COLORS ------------------------------------------------------------

export CLICOLOR=1
export GREP_OPTIONS='--color=auto'

