# PATH --------------------------------------------------------------

if [ -d ~/bin ] ; then
	export PATH=$PATH:~/bin
fi


# TERM --------------------------------------------------------------

export TERM=xterm-256color


# EDITOR ------------------------------------------------------------

export EDITOR=/usr/bin/vim


# BASHRC ------------------------------------------------------------

if [ -e ~/.bashrc ] ; then
	source ~/.bashrc
fi


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


# OTHER APPS --------------------------------------------------------

# MySQL
export PATH=$PATH:/usr/local/mysql/bin
export FTP_PASSIVE=1

# Setting PATH for Python 2.6
export PATH="/Library/Frameworks/Python.framework/Versions/2.6/bin:${PATH}"

# Setting PATH for Python 3.1
export PATH="/Library/Frameworks/Python.framework/Versions/3.1/bin:${PATH}"

# Git (Xcode installs older version at /usr/bin)
export PATH="/usr/local/git/bin:${PATH}"
