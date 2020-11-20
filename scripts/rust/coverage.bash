#!/usr/bin/env bash
#
# Get coverage from Rust tests.

set -eu

LLVM_ROOT=${LLVM_ROOT:-"$HOME/src/third_party/rust/build/x86_64-apple-darwin/llvm/bin"}
OUTPUT_DIR="./target/coverage"


# Run all tests generate coverage data for each.
RUSTFLAGS="${RUSTFLAGS:-""} -Zinstrument-coverage" \
	LLVM_PROFILE_FILE="$OUTPUT_DIR/tests.%p.profraw" \
	cargo test --all-features

# Merge all coverage data into a single profile.
"$LLVM_ROOT/llvm-profdata" merge \
	--output "$OUTPUT_DIR/tests.profdata" \
	"$OUTPUT_DIR"/tests.*.profraw

# Generate a HTML report for the coverage, excluding all files not in `src/`.
find target/debug/deps -perm -111 -type f -maxdepth 1 | xargs printf -- "--object '%s' " | xargs  \
	"$LLVM_ROOT/llvm-cov" show \
	--show-instantiations=false \
	--show-expansions \
	--ignore-filename-regex "^[^src]" \
	--format html \
	--output-dir "$OUTPUT_DIR/report" \
	--instr-profile "$OUTPUT_DIR/tests.profdata"

open "$OUTPUT_DIR/report/index.html"
