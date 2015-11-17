function homestead --description 'Laravel Homestead utility'
	set -l cmd

	if test (count $argv) -eq 0
		set cmd help
	else
		set cmd $argv[1]
	end

	switch $cmd
		case help --help
			echo 'Usage: homestead <command> [<args>]'
			echo
			echo '  help    Show this help message'
			echo '  add     Add Homestead box to Vagrant'
			echo '  update  Update Homestead box to latest version'
			echo '  edit    Edit the global Homestead.yaml configuration file'
			echo
			echo 'Any other <command> is passed to vagrant and run in the context of'
			echo 'the Homestead directory (e.g., up, halt, ssh, provision, destroy).'
		case add
			vagrant box add laravel/homestead
		case update
			__homestead_do vagrant box update
		case edit
			eval $EDITOR $HOME/.homestead/Homestead.yaml
		case '*' # e.g., up, halt, ssh, provision, destroy
			__homestead_do vagrant $argv
	end
end

set -g __homestead_repo $HOME/src/homestead

function __homestead_do
	pushd $__homestead_repo
	and begin
		eval $argv
		popd
	end
end
