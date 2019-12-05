#!/bin/bash
#
# Run a command in a loop until it fails.

set -eu

for (( ;; )); do
	"$1" "${@:2}"
done
