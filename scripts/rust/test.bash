#!/bin/bash
#
# Run all rust tests via Cargo.

set -eu

# Import `silent`.
source "${BASH_SOURCE%/*}/../util.bash" || exit 1

silent "Running tests" \
	"cargo test --all --bins --tests --examples --benches --all-targets"
