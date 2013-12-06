#!/usr/bin/env bats

load test_helper
fixtures list

SPORE_CMD="./spore --dry-run list"

@test "exits with status SPORE_ERROR_NOT_FOUND when vimrc not found" {
	export VIM_DIR=foo/vimrc
	run $SPORE_CMD
	[[ "$status" == $SPORE_ERROR_NOT_FOUND ]]
}

@test "list prints category names" {
	run $SPORE_CMD
	[[ "$status" == 0 ]]
}
