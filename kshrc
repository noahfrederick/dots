# PROMPT ------------------------------------------------------------

COLOR_BOLD="\033[1m"
COLOR_DEFAULT="\033[0m"

# user@host cwd >
PS1=`echo $COLOR_BOLD``logname`@`hostname`' $PWD > '`echo $COLOR_DEFAULT`
PS2=`echo "$COLOR_BOLD > $COLOR_DEFAULT"`
