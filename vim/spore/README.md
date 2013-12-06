# vim-spore

Command-line tool for managing Vim plug-ins in ~/.vim/bundle

## Testing

Spore has a [bats](https://github.com/sstephenson/bats) test suite. The
easiest way to install bats on OS X is with Homebrew:

	brew install bats

You can run the tests by pointing bats to the `test` directory:

	bats test
