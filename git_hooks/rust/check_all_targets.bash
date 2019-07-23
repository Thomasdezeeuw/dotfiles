#!/bin/bash

set -eu

echo "Checking targets"

# Import `silent`.
source "${BASH_SOURCE%/*}/../util.bash" || exit 1

check() {
	target="$1"

	# Adding new target.
	silent "Adding $target" "rustup target add $target"

	silent "Checking target $target" \
		"cargo check --all --bins --tests --examples --benches --all-targets --target $target"
}

# Check various targets.
check "x86_64-apple-darwin"
check "x86_64-unknown-freebsd"
check "x86_64-unknown-netbsd"
check "x86_64-unknown-linux-gnu"
check "x86_64-unknown-linux-musl"
check "aarch64-linux-android"
check "x86_64-pc-windows-gnu"
check "x86_64-pc-windows-msvc"

exit 0
