#!/usr/bin/env bash
#
# Create a latex pdf, without all the intermediate files.

set -u

input=$1
tmp_dir=$(mktemp -d)

[ "${input: -4}" != ".tex" ] && echo "Expected .tex file" && exit 1

base_name=$(basename -s .tex "$input")

# Be quite when successful, loud otherwise (like Unix tools should).
output=$(\latex -interaction=nonstopmode -halt-on-error -output-format=pdf \
	-output-directory="$tmp_dir" "$input" 2>&1)
ok=$?

if [ $ok -eq 0 ]; then
	# Run latex again to fix reference, which often don't work after a single
	# run.
	latex -interaction=nonstopmode -halt-on-error -output-format=pdf \
		-output-directory="$tmp_dir" "$input" > /dev/null 2>&1
	mv "$tmp_dir/$base_name.pdf" .
else
	echo "$output"
	exit 1
fi
