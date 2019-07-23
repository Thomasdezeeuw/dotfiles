#!/bin/bash

set -eu

SOURCE=$(readlink $BASH_SOURCE)

"${SOURCE%/*}/../../no_wip_commits.bash"

"${SOURCE%/*}/pre-commit.bash"

exit 0
