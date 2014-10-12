#
# PATH
#
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

#
# EDITOR
#
set -gx EDITOR vim

#
# COLORS
#
set -gx CLICOLOR 1
set -gx GREP_OPTIONS '--color=auto'

set -g fish_color_command     green   --bold
set -g fish_color_cwd         yellow
set -g fish_color_end         green
set -g fish_color_error       red     --bold
set -g fish_color_escape      purple
set -g fish_color_valid_path  blue    --underline

#
# ALIASES
#
function v;   vim $argv; end
function vs;  vim -S $argv; end
function o;   if [ -z $argv[1] ]; open .; else; open $argv; end; end
function g;   if [ -z $argv[1] ]; git status --short; else; git $argv; end; end
function ga;  git add $argv; end
function gb;  git branch $argv; end
function gc;  git commit $argv; end
function gca; git commit -a $argv; end
function gcl; git clone $argv; end
function gco; git checkout $argv; end
function gd;  git diff $argv; end
function gdc; git diff --cached $argv; end
function gf;  git fetch $argv; end
function gg;  git graph $argv; end
function gl;  git log $argv; end
function gp;  git push $argv; end
function gpu; git pull $argv; end
function gs;  git status $argv; end

# Make fish work with boxen
set -l FISH_BOXEN ~/.config/fish/boxen.fish
test -r $FISH_BOXEN; and test -d /opt/boxen; and source $FISH_BOXEN
