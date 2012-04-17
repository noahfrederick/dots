#!/bin/bash
# install.sh
# Create symlinks to config files

DOTFILES=~/.dotfiles
BACKUP=~/.dotfiles_backup

for FILE in $DOTFILES/*
do
	BASE=`basename $FILE`

	# Exclude the README and installation script
	if [[ "README.md" == "$BASE" || `basename $0` == "$BASE" ]] ; then
		continue
	fi
	
	if [ -h $HOME/.$BASE ] ; then
		echo "Skipping ~/.$BASE (symlink already exists)"
		continue
	elif [ -e $HOME/.$BASE ] ; then
		echo "Backing up ~/.$BASE"
		mkdir -p $BACKUP
		mv -v $HOME/.$BASE $BACKUP/.$BASE
	fi

	echo "Linking $FILE to ~/.$BASE"
	ln -s $FILE $HOME/.$BASE
done
