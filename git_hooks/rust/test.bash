#!/bin/bash

set -eu

echo "Testing"

# Import `silent`.
source "${BASH_SOURCE%/*}/../util.bash" || exit 1

silent "Running tests" \
	"cargo test --all --bins --tests --examples --benches --all-targets"

exit 0
