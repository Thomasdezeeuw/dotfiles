#!/bin/bash

set -eu

SOURCE=$(readlink -n "$BASH_SOURCE" || echo "$BASH_SOURCE")

"${SOURCE%/*}/../../no_wip_commits.bash"

"${SOURCE%/*}/pre-commit.bash"

exit 0
