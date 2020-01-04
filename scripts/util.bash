#!/bin/bash
#
# Collection of utility functions.

set -u

# Only prints output when the command fails.
silent() {
	set +e; # We're catching errors.

	msg="$1"
	cmd="$2"

	output=$($cmd 2>&1)
	result=$?
	if [[ $result != 0 ]]; then
		echo "$msg" 1>&2
		echo "" 1>&2
		echo "$output" 1>&2
		echo "" 1>&2
		echo "Run again with:" 1>&2
		echo "$cmd" 1>&2
		exit 1
	fi

	set -e
}

# Stash anything that is not committed.
#
# Used in the following way.
# ```bash
# stash
# trap return_stash EXIT
# ```
STASH_NAME="pre-commit-$(date +%s)"
stash() {
	git stash save --quiet --keep-index "$STASH_NAME" || exit 1
}

# And put it back once we're done.
return_stash() {
	stashes=$(git stash list)
	if [[ "$stashes" == *"$STASH_NAME"* ]]; then
		git stash pop --quiet || exit 1
	fi
}
