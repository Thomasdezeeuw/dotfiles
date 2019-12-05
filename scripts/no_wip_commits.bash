#!/bin/bash
#
# Checks the last $N commits to make sure they don't contain work in progress
# commits.

N=100

set -u

git log -n $N --pretty=oneline | grep --ignore-case "wip" 1>&2
found=$?
if [[ $found == 0 ]]; then
	echo "Found WIP commit(s)" 1>&2
fi
