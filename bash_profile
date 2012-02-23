# PATH --------------------------------------------------------------

if [ -d ~/bin ] ; then
	export PATH=$PATH:~/bin
fi


# EDITOR ------------------------------------------------------------

export EDITOR=/usr/bin/vim


# BASHRC ------------------------------------------------------------

if [ -e ~/.bashrc ] ; then
	source ~/.bashrc
fi


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
