#!/bin/bash
#
# Run a number of checks before we push code.

set -eu

# The parent directory of this script, works if its system-linked.
SOURCE=$(readlink -n "$BASH_SOURCE" || echo "$BASH_SOURCE")

# Import `stash` and `return_stash`.
source "${SOURCE%/*}/../util.bash" || exit 1

# We don't want to push WIP commits.
"${SOURCE%/*}/../no_wip_commits.bash"

# Run all the checks we do in committing.
"${SOURCE%/*}/rust.pre-commit.bash"
