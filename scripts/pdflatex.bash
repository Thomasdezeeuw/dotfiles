#!/bin/bash
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

if [ $? -ne 0 ]; then
	echo "$output"
	exit 1
else
	latex -interaction=nonstopmode -halt-on-error -output-format=pdf \
		-output-directory="$tmp_dir" "$input" 2>&1 > /dev/null
	mv "$tmp_dir/$base_name.pdf" .
fi
