#!/usr/bin/env fish

# Manually translated from scripts at /opt/boxen/env.sh and /opt/boxen/env.d/*

# Make the root of Boxen available.

set -x BOXEN_HOME /opt/boxen

# Add homebrew'd stuff to the path.

prepend_to_path $BOXEN_HOME/homebrew/sbin
prepend_to_path $BOXEN_HOME/homebrew/bin

# Add homebrew'd stuff to the manpath.

prepend_to_manpath $BOXEN_HOME/homebrew/share/man

# Add any binaries specific to Boxen to the path.

prepend_to_path $BOXEN_HOME/bin

set -x BOXEN_SETUP_VERSION (env GIT_DIR=$BOXEN_HOME/repo/.git git rev-parse --short HEAD)

set -x BOXEN_BIN_DIR /opt/boxen/bin
set -x BOXEN_CONFIG_DIR /opt/boxen/config
set -x BOXEN_DATA_DIR /opt/boxen/data
set -x BOXEN_ENV_DIR /opt/boxen/env.d
set -x BOXEN_LOG_DIR /opt/boxen/log
set -x BOXEN_SOCKET_DIR /opt/boxen/data/project-sockets
set -x BOXEN_SRC_DIR "$HOME/src"

# Expose GitHub credentials

set -x BOXEN_GITHUB_LOGIN noahfrederick

set -x HOMEBREW_ROOT /opt/boxen/homebrew
set -x HOMEBREW_CACHE /opt/boxen/cache/homebrew

set -x CFLAGS "-I$HOMEBREW_ROOT/include"
set -x LDFLAGS "-L$HOMEBREW_ROOT/lib"

# Configure and activate rbenv. You know, for rubies.

set -x RBENV_ROOT $BOXEN_HOME/rbenv
prepend_to_path $RBENV_ROOT/plugins/ruby-build/bin
prepend_to_path $RBENV_ROOT/bin
prepend_to_path $RBENV_ROOT/shims
rbenv rehash 2>/dev/null

# Allow bundler to use all the cores for parallel installation

set -x BUNDLE_JOBS 4

# Add ./bin to the path. This happens after initialization to make
# sure local stubs take precedence over stuff like rbenv.

prepend_to_path bin

set -x BOXEN_MYSQL_PORT 13306
set -x BOXEN_MYSQL_SOCKET /opt/boxen/data/mysql/socket
set -x BOXEN_MYSQL_URL "mysql://$USER@localhost:13306/"
