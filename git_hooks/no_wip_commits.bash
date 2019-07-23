#!/bin/bash

set -u

# Check the last 100 commits to make sure they don't contain work in progress
# commits.
git log -n 100 --pretty=oneline | grep --ignore-case "wip" 1>&2
found=$?
if [[ $found == 0 ]]; then
	echo "Found WIP commit(s)" 1>&2
fi
