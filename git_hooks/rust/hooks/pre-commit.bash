#!/bin/bash

set -eu

SOURCE=$(readlink $BASH_SOURCE)

# Import `stash` and `return_stash`.
source "${SOURCE%/*}/../../util.bash"

stash
trap return_stash EXIT

"${SOURCE%/*}/../test.bash"

exit 0
