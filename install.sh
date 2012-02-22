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
		echo "Symlink $HOME/.$BASE already exists... skipping ..."
		continue
	elif [ -e $HOME/.$BASE ] ; then
		echo "File $HOME/.$BASE already exists... backing up ..."
		mkdir -p $BACKUP
		mv -v $HOME/.$BASE $BACKUP/.$BASE
	fi

	echo "Linking $FILE to $HOME/.$BASE ..."
	ln -s $FILE $HOME/.$BASE
done
