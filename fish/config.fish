#
# FISH
#
set fish_greeting

set fish_color_autosuggestion    brblack
set fish_color_command           green   --bold
set fish_color_comment           brblack
set fish_color_cwd               brblack --bold
set fish_color_end               green
set fish_color_error             normal
set fish_color_escape            purple
set fish_color_param             green
set fish_color_quote             yellow
set fish_color_valid_path        blue    --underline
set fish_pager_color_prefix      yellow
set fish_pager_color_completion  white
set fish_pager_color_description purple

#
# LOGIN SHELL
#
status is-login; or exit

#
# PATH
#
which -s yarn;     and prepend_to_path (yarn global bin)
which -s rbenv;    and prepend_to_path (rbenv root)/shims
which -s composer; and prepend_to_path (composer config --global home)/(composer config --global bin-dir)
prepend_to_path $HOME/bin

#
# DIRECTORIES
#
set -x DOCS      "$HOME/Documents"
set -x DROPBOX   "$HOME/Sync"
set -x NOTES     "$HOME/Notes"
set -x CODE      "$HOME/src"
set -x HOMESTEAD "$CODE/homestead"

append_to_cdpath "."
append_to_cdpath "$CODE"

#
# EDITOR
#
set -x EDITOR nvim

#
# MAN
#
set -x MANPAGER 'nvim -c "set filetype=man" -'

#
# COLORS
#
set -x CLICOLOR 1

#
# HOMEBREW
#
set -x HOMEBREW_NO_ANALYTICS 1
set -x HOMEBREW_NO_INSECURE_REDIRECT 1
set -x HOMEBREW_CASK_OPTS --require-sha

#
# FZF
#
set -x FZF_DEFAULT_OPTS "--inline-info --color=16,info:8"

#
# INTERACTIVE LOGIN SHELL
#
status is-interactive; or exit

#
# ABBREVIATIONS
#
abbr --add art php artisan
abbr --add br  brew
abbr --add bru brew upgrade
abbr --add c   composer
abbr --add ci  composer install
abbr --add cu  composer update
abbr --add cr  composer require
abbr --add cgi composer global install
abbr --add cgu composer global update
abbr --add cgr composer global require
abbr --add cda composer dump-autoload
abbr --add ch  composer show
abbr --add cm  composer remove
abbr --add cs  composer search
abbr --add cv  composer validate
abbr --add e   emacsclient
abbr --add ee  emacsclient --eval
abbr --add en  emacsclient --no-wait
abbr --add et  emacsclient --tty
abbr --add g   git
abbr --add ga  git add
abbr --add gaa git add --all
abbr --add gb  git branch
abbr --add gbd git branch --delete
abbr --add gc  git commit --verbose
abbr --add gca git commit --all --verbose
abbr --add gcb git checkout --branch
abbr --add gcf git commit --verbose --fixup
abbr --add gcl git clone
abbr --add gco git checkout
abbr --add gd  git diff
abbr --add gdc git diff --cached
abbr --add gf  git fetch
abbr --add gi  git init
abbr --add gl  git log
abbr --add gm  git merge
abbr --add gp  git push
abbr --add gpu git pull
abbr --add gr  git rebase
abbr --add gs  git status
abbr --add gst git stash
abbr --add gsp git stash pop
abbr --add lba ledger balance
abbr --add leq ledger equity
abbr --add lst ledger stats
abbr --add lre ledger register
abbr --add lxa ledger xact
abbr --add v   nvim
abbr --add vs  nvim -S
abbr --add vn  nvim -u NONE
abbr --add vd  nvim --noplugin -u minimal.vim
abbr --add wk  webkit2png --fullsize --timestamp
abbr --add ww  words
abbr --add we  words --english
abbr --add wi  words --interactive
