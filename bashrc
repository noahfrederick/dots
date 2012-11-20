# If not running interactively, don't do anything
[ -z "$PS1" ] && return

source ~/.bash/env     # Environment variables
source ~/.bash/config  # Completion and other settings
source ~/.bash/prompt  # The prompt
source ~/.bash/aliases # Aliases and functions
