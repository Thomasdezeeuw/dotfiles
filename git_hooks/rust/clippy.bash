#!/bin/bash

set -eu

echo "Clippy check"

# Import `silent`.
source "${BASH_SOURCE%/*}/../util.bash" || exit 1

# Failing the `cognitive-complexity' lint is allowed because the tests are too
# complex.
silent "Running clippy" \
	"cargo clippy --all-targets --all-features -- \
		-D warnings \
		-A clippy::cognitive-complexity \
		-A clippy::needless_lifetimes" # I disagree with this.

exit 0
