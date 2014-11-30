function gpg_backup -d "Create tar archive of GPG files"
	tar -cf /Volumes/NOXOID/gnupg-backup.tar --exclude '*.gpg-agent' -C $HOME .gnupg/
end
