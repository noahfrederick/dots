# PATH --------------------------------------------------------------

if [ -d ~/bin ] ; then
	export PATH="${PATH}:~/bin"
fi


# EDITOR ------------------------------------------------------------

hash vim &>/dev/null && export EDITOR=vim


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
