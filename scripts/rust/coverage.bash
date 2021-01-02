#!/usr/bin/env bash
#
# Get coverage from Rust tests.

set -eu

# Set by `rustup run`, or we get it ourselves.
# Example value: `nightly-x86_64-apple-darwin`.
RUSTUP_TOOLCHAIN="${RUSTUP_TOOLCHAIN:-"$(rustup show active-toolchain | cut -d' ' -f1)"}"
# Architecture target. Example value: `x86_64-apple-darwin`.
RUSTUP_TARGET="${RUSTUP_TARGET:-"$(echo $RUSTUP_TOOLCHAIN | cut -d'-' -f2,3,4)"}"
# Location of LLVM tools, as install by `install_llvm_tools`.
LLVM_BIN="${LLVM_ROOT:-"$(rustc --print sysroot)/lib/rustlib/$RUSTUP_TARGET/bin"}"
# Where we put the coverage output.
COVERAGE_OUTPUT="./target/coverage"

# Remove old coverage data.
rm -rf "$COVERAGE_OUTPUT"

# Run the tests with the LLVM instrumentation.
RUSTFLAGS="${RUSTFLAGS:-""} -Zinstrument-coverage" \
	LLVM_PROFILE_FILE="$COVERAGE_OUTPUT/tests.%p.profraw" \
	cargo test --all-features

# Merge all coverage data into a single profile.
"$LLVM_BIN/llvm-profdata" merge \
	--output "$COVERAGE_OUTPUT/tests.profdata" \
	"$COVERAGE_OUTPUT"/tests.*.profraw

# Generate a HTML report for the coverage, excluding all files not in `src/`.
find target/debug/deps -perm -111 -type f -maxdepth 1 | xargs printf -- "--object '%s' " | xargs  \
	"$LLVM_BIN/llvm-cov" show \
	--show-instantiations=false \
	--show-expansions \
	--ignore-filename-regex "^[^src]" \
	--format html \
	--output-dir "$COVERAGE_OUTPUT/report" \
	--instr-profile "$COVERAGE_OUTPUT/tests.profdata"

open "$COVERAGE_OUTPUT/report/index.html"
