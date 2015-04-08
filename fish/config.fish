#
# PATH
#
prepend_to_path $HOME/.composer/vendor/bin
prepend_to_path $HOME/bin

#
# FISH
#
set -g fish_greeting

#
# DIRECTORIES
#
set -gx DOCS     "$HOME/Documents"
set -gx LOGBOOK  "$DOCS/Logbook"
set -gx DROPBOX  "$HOME/Dropbox"
set -gx NOTES    "$DROPBOX/Notes"
set -gx CODE     "$HOME/src"
set -gx BLOG     "$CODE/noahfrederick.com"

append_to_cdpath "."
append_to_cdpath "$CODE"

#
# EDITOR
#
set -gx EDITOR vim

#
# COLORS
#
set -gx CLICOLOR 1

set -g fish_color_command     green   --bold
set -g fish_color_cwd         yellow
set -g fish_color_end         green
set -g fish_color_error       red     --bold
set -g fish_color_escape      purple
set -g fish_color_valid_path  blue    --underline

#
# PINENTRY
#
# Suppress GUI prompt--use terminal
set -gx PINENTRY_USER_DATA "USE_CURSES=1"
set -gx GPG_TTY (tty)

#
# ABBREVIATIONS
#
abbr --add g   git
abbr --add ga  git add
abbr --add gb  git branch
abbr --add gc  git commit
abbr --add gca git commit --all
abbr --add gcl git clone
abbr --add gco git checkout
abbr --add gd  git diff
abbr --add gdc git diff --cached
abbr --add gf  git fetch
abbr --add gg  git graph
abbr --add gl  git log
abbr --add gp  git push
abbr --add gpu git pull
abbr --add gs  git status
abbr --add gst git stash
abbr --add gsp git stash pop

# Make fish work with boxen
set -l FISH_BOXEN ~/.config/fish/boxen.fish
test -r $FISH_BOXEN; and test -d /opt/boxen; and source $FISH_BOXEN
