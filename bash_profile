# PATH --------------------------------------------------------------

if [ -d ~/bin ] ; then
	export PATH="${PATH}:~/bin"
fi


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

# MySQL
if [ -d /usr/local/mysql/bin ] ; then
	export PATH="${PATH}:/usr/local/mysql/bin"
fi

# rbenv
hash rbenv &>/dev/null && eval "$(rbenv init -)"
