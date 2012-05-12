# Nox's *Nix Config Files

My configuration files for the platforms I work on, OS X, Linux (Ubuntu), and occasionally Solaris.


## Installation

	git clone git@github.com:noahfrederick/dotfiles.git ~/.dotfiles
	cd ~/.dotfiles
	git submodule update --init
	./install.sh

Existing configuration files are moved to:

	~/.dotfiles_backup

And new symlinks are created. Existing symlinks will be left as they are.

