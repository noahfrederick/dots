fixtures() {
  FIXTURE_ROOT="$BATS_TEST_DIRNAME/fixtures/$1"
}

setup() {
  export TMP="$BATS_TEST_DIRNAME/tmp"
  export VIM_DIR="$FIXTURE_ROOT"
  export VIM_BUNDLE_DIR="$TMP/bundle"
  # Error exit codes
  readonly SPORE_ERROR_UNKNOWN=1
  readonly SPORE_ERROR_USAGE=2
  readonly SPORE_ERROR_MISSING_ARGUMENTS=3
  readonly SPORE_ERROR_NOT_FOUND=4
}

teardown() {
  rm -f "$TMP/*"
}
