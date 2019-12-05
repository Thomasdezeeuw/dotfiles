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
# macOS.
check "x86_64-apple-darwin"
# FreBSD
check "x86_64-unknown-freebsd"
# NetBSD.
check "x86_64-unknown-netbsd"
# Linux.
check "x86_64-unknown-linux-gnu"
check "x86_64-unknown-linux-musl"
# Android.
check "aarch64-linux-android"
# Windows.
check "x86_64-pc-windows-gnu"
check "x86_64-pc-windows-msvc"
# iOS.
check "x86_64-apple-ios"
check "i386-apple-ios"
check "armv7s-apple-ios"
