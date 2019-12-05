#!/bin/bash
#
# Check if the code is formatted correctly, using rustfmt.

set -eu

# Import `silent`.
source "${BASH_SOURCE%/*}/../util.bash" || exit 1

silent "Running clippy" "cargo fmt --all -- --check"
