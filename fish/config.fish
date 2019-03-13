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
set fish_pager_color_prefix      yellow
set fish_pager_color_completion  white
set fish_pager_color_description purple

#
# ABBREVIATIONS
#
if status is-interactive
	abbr --add --global art php artisan
	abbr --add --global br  brew
	abbr --add --global bru brew upgrade
	abbr --add --global c   capture
	abbr --add --global ca  capture
	abbr --add --global cap capture
	abbr --add --global cda composer dump-autoload
	abbr --add --global cgi composer global install
	abbr --add --global cgr composer global require
	abbr --add --global cgu composer global update
	abbr --add --global ch  composer show
	abbr --add --global ci  composer install
	abbr --add --global cm  composer remove
	abbr --add --global co  composer install
	abbr --add --global cr  composer require
	abbr --add --global cs  composer search
	abbr --add --global cu  composer update
	abbr --add --global cv  composer validate
	abbr --add --global e   emacsclient
	abbr --add --global ee  emacsclient --eval
	abbr --add --global en  emacsclient --no-wait
	abbr --add --global et  emacsclient --tty
	abbr --add --global g   git
	abbr --add --global ga  git add
	abbr --add --global gaa git add --all
	abbr --add --global gb  git branch
	abbr --add --global gbd git branch --delete
	abbr --add --global gbm git branch --merged
	abbr --add --global gc  git commit --verbose
	abbr --add --global gca git commit --all --verbose
	abbr --add --global gcb git checkout --branch
	abbr --add --global gcf git commit --verbose --fixup
	abbr --add --global gcl git clone
	abbr --add --global gco git checkout
	abbr --add --global gd  git diff
	abbr --add --global gdc git diff --cached
	abbr --add --global gf  git fetch
	abbr --add --global gi  git init
	abbr --add --global gl  git log
	abbr --add --global gm  git merge
	abbr --add --global gp  git push
	abbr --add --global gpu git pull
	abbr --add --global gr  git rebase
	abbr --add --global grc git rebase --continue
	abbr --add --global grs git rebase --skip
	abbr --add --global gs  git status
	abbr --add --global gsp git stash pop
	abbr --add --global gst git stash
	abbr --add --global lba ledger balance
	abbr --add --global leq ledger equity
	abbr --add --global lre ledger register
	abbr --add --global lst ledger stats
	abbr --add --global lxa ledger xact
	abbr --add --global n   note
	abbr --add --global t   task
	abbr --add --global ta  task add
	abbr --add --global tc  task context
	abbr --add --global tl  task log
	abbr --add --global tp  task rc.context:none projects
	abbr --add --global ts  task show
	abbr --add --global tt  task rc.context:none tags
	abbr --add --global tw  task waiting
	abbr --add --global v   nvim
	abbr --add --global vd  nvim --noplugin -u minimal.vim
	abbr --add --global vn  nvim -u NONE
	abbr --add --global vs  nvim -S
	abbr --add --global we  words --english
	abbr --add --global wi  words --interactive
	abbr --add --global wk  webkit2png --fullsize --timestamp
	abbr --add --global ww  words
end

#
# LOGIN SHELL
#
status is-login; or exit

#
# PATH
#
prepend_to_path $HOME/.rbenv/bin # For non-brew-installed rbenv
type -fq yarn;     and prepend_to_path (yarn global bin)
type -fq composer; and prepend_to_path (composer config --global home)/(composer config --global bin-dir)
type -fq rbenv;    and source (rbenv init - | psub)
prepend_to_path $HOME/.cargo/bin
prepend_to_path $HOME/.local/bin

#
# DIRECTORIES
#
test -d "$HOME/Documents"; and set -x DOCS      "$HOME/Documents"
test -d "$HOME/Sync";      and set -x DROPBOX   "$HOME/Sync"
test -d "$HOME/Notes";     and set -x NOTES     "$HOME/Notes"
test -d "$HOME/src";       and set -x CODE      "$HOME/src"
test -d "$HOME/Code";      and set -x CODE      "$HOME/Code"
test -d "$HOME/Work";      and set -x WORK      "$HOME/Work"
test -d "$CODE/homestead"; and set -x HOMESTEAD "$CODE/homestead"

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
set -x FZF_DEFAULT_OPTS '--inline-info --color=16,info:8'
set -x FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS --bind=change:top,ctrl-n:preview-down,ctrl-p:preview-up"

#
# GPG
#
set -x GPG_TTY (tty)
