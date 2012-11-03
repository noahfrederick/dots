# PATH --------------------------------------------------------------

case ":$PATH:" in
	*":~/bin:"*) ;;
	*) [ -d ~/bin ] && export PATH="~/bin:${PATH}" ;;
esac


# EDITOR ------------------------------------------------------------

hash vim &>/dev/null && export EDITOR=vim


# COMPLETION --------------------------------------------------------

if hash brew &>/dev/null && [ -f $(brew --prefix)/etc/bash_completion ]; then
	source $(brew --prefix)/etc/bash_completion
fi


# BASHRC ------------------------------------------------------------

if [ -e ~/.bashrc ] ; then
	source ~/.bashrc
fi


# OTHER APPS --------------------------------------------------------

export FTP_PASSIVE=1

# rbenv
hash rbenv &>/dev/null && eval "$(rbenv init -)"
