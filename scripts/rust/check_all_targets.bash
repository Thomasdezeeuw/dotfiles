#!/bin/bash
#
# Check the code on all known targets.

set -eu

# Import `silent`.
source "${BASH_SOURCE%/*}/../util.bash" || exit 1

check() {
	target="$1"

	# Ensure the target is available.
	silent "Adding $target" "rustup target add $target"

	silent "Checking target $target" \
		"cargo check --all-features --all --bins --tests --examples --benches --all-targets --target $target"
}

# Check various targets.
# macOS.
check "x86_64-apple-darwin"
# iOS.
check "x86_64-apple-ios"
check "i386-apple-ios"
check "armv7s-apple-ios"
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
