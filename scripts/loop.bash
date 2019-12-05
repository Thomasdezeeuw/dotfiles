#!/bin/bash

set -eu

for (( ;; )); do
	"$1" "${@:2}"
done
