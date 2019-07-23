#!/bin/bash

set -eu

SOURCE=$(readlink $BASH_SOURCE)

"${SOURCE%/*}/../../no_wip_commits.bash"

"${SOURCE%/*}/pre-commit.all.bash"

exit 0
