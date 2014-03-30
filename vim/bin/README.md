# vim-spore

Command-line tool for managing Vim plug-ins in ~/.vim/bundle

## Usage

	spore [<options>] <command> [<plug-in>]

	Options:
		-d, --dry-run   See what commands would be run without doing anything
		-v, --verbose   Verbose output

	Commands:
		install         Install missing plug-ins listed in SPORE_FILE, or <plug-in> if given
		uninstall       Uninstall <plug-in>
		update          Update each plug-in listed in SPORE_FILE, or <plug-in> if given
		list            List all plug-ins registered in your SPORE_FILE
		version         Print version info
		help            Print this help message

The default location of your `SPORE_FILE`, which lists your plug-ins is `~/.vim/Spore`.

## Testing

Spore has a [bats](https://github.com/sstephenson/bats) test suite. The
easiest way to install bats on OS X is with Homebrew:

	brew install bats

You can run the tests by pointing bats to the `test` directory:

	bats test
