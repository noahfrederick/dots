function homestead --description 'Laravel Homestead utility'
	set -l cmd

	if test (count $argv) -eq 0
		set cmd help
	else
		set cmd $argv[1]
	end

	switch $cmd
		case help --help -h
			echo 'Usage: homestead <command> [<args>]'
			echo
			echo '  help    Show this help message'
			echo '  install Install Homestead and add box to Vagrant'
			echo '  update  Update Homestead and Vagrant box to latest version'
			echo '  edit    Edit the global Homestead.yaml configuration file'
			echo '  aliases Edit the global shell aliases file'
			echo
			echo 'Any other <command> is passed to vagrant and run in the context of'
			echo 'the Homestead directory (e.g., up, halt, ssh, provision, destroy).'
		case install
			vagrant box add laravel/homestead
			and git clone https://github.com/laravel/homestead.git "$HOMESTEAD"
			and __homestead_do bash init.sh
		case update
			__homestead_do vagrant box update
			and __homestead_do git pull --ff-only
		case edit
			if test (count $argv) -eq 1
				__homestead_edit Homestead.yaml
			else
				__homestead_edit $argv[2]
			end
		case aliases alias
			__homestead_edit aliases
		case '*' # e.g., up, halt, ssh, provision, destroy
			__homestead_do vagrant $argv
	end
end

function __homestead_edit
	eval $EDITOR "$HOMESTEAD/$argv[1]"
end

function __homestead_do
	pushd "$HOMESTEAD"
	and begin
		eval $argv
		popd
	end
end
