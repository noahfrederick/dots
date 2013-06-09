#
# PATH
#
function prepend_to_path -d "Prepend the given dir to PATH if it exists and is not already listed"
	if test -d $argv[1]
		if not contains $argv[1] $PATH
			set -gx PATH "$argv[1]" $PATH
		end
	end
end
prepend_to_path $HOME/bin

#
# FISH
#
set -gx fish_greeting ''
function fish_user_key_bindings
    bind \cn accept-autosuggestion
end

#
# DIRECTORIES
#
set -gx DOCS     "$HOME/Documents"
set -gx NOTES    "$DOCS/logbook"
set -gx PROJECTS "$HOME/projects"
set -gx WEBSITES "$HOME/Sites"
set -gx BLOG     "$WEBSITES/noahfrederick.com/jekyll"

#
# EDITOR
#
set -gx EDITOR vim

#
# COLORS
#
set -gx CLICOLOR 1
set -gx GREP_OPTIONS '--color=auto'

#
# RUBY
#
prepend_to_path $HOME/.rbenv/bin
prepend_to_path $HOME/.rbenv/shims

if test -d $HOME/.rbenv
	rbenv rehash >/dev/null ^&1
end

#
# PHP
#
prepend_to_path (brew --prefix josegonzalez/php/php54)/bin

#
# ALIASES
#
function v;   vim $argv; end
function vs;  vim -S $argv; end
function r;   rails $argv; end
function t;   task $argv; end
function ts;  task summary $argv; end
function tp;  taskwarrior-project.bash $argv; end
function ta;  taskwarrior-project.bash add $argv; end
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
function gg;  git g $argv; end
function ggg; git graph $argv; end
function gl;  git log $argv; end
function gp;  git push $argv; end
function gpu; git pull $argv; end
function gs;  git status $argv; end
