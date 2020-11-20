#!/usr/bin/env bash
#
# Get coverage from Rust tests.

set -eu

TMP_DIR=${TMP_DIR:-"./tmp_coverage_data"}
LLVM_ROOT=${LLVM_ROOT:-"$HOME/src/third_party/rust/build/x86_64-apple-darwin/llvm/bin"}


# Run all tests generate coverage data for each.
RUSTFLAGS="${RUSTFLAGS:-""} -Zinstrument-coverage" \
	LLVM_PROFILE_FILE="$TMP_DIR/tests.%p.profraw" \
	cargo test --all-features

# Merge all coverage data into a single profile.
"$LLVM_ROOT/llvm-profdata" merge \
	--output "$TMP_DIR/tests.profdata" \
	"$TMP_DIR"/tests.*.profraw

# Generate a HTML report for the coverage, excluding all files not in `src/`.
find target/debug/deps -perm -111 -type f -maxdepth 1 | xargs printf -- "--object '%s' " | xargs  \
	"$LLVM_ROOT/llvm-cov" show \
	--show-instantiations=false \
	--show-expansions \
	--ignore-filename-regex "^[^src]" \
	--format html \
	--output-dir "$TMP_DIR/report" \
	--instr-profile "$TMP_DIR/tests.profdata"

open "$TMP_DIR/report/index.html"
