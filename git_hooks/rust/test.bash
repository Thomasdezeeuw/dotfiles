#!/bin/bash

set -eu

echo "Testing"

# Import `silent`.
source "${BASH_SOURCE%/*}/../util.bash" || exit 1

silent "Running tests" "cargo test"

exit 0
