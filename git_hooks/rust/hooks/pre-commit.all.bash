#!/bin/bash

set -eu

SOURCE=$(readlink -n "$BASH_SOURCE" || echo "$BASH_SOURCE")

# Import `stash` and `return_stash`.
source "${SOURCE%/*}/../../util.bash"

stash
trap return_stash EXIT

"${SOURCE%/*}/../check_all_targets.bash"
"${SOURCE%/*}/../test.bash"
"${SOURCE%/*}/../clippy.bash"

exit 0
