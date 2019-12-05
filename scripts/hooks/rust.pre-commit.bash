#!/bin/bash
#
# Run a number of checks before we commit code.

set -eu

# The parent directory of this script, works if its system-linked.
SOURCE=$(readlink -n "$BASH_SOURCE" || echo "$BASH_SOURCE")

# Import `stash` and `return_stash`.
source "${SOURCE%/*}/../util.bash" || exit 1

# Stash the commits and put the changes back once we're done.
stash
trap return_stash EXIT

echo "Checking targets"
"${SOURCE%/*}/../rust/check_all_targets.bash"

echo "Testing"
"${SOURCE%/*}/../rust/test.bash"

echo "Clippy check"
"${SOURCE%/*}/../rust/clippy.bash"

echo "Checking formatting"
"${SOURCE%/*}/../rust/rustfmt.bash"
