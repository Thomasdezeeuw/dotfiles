#!/usr/bin/env bash
#
# Get public keys for a GitHub user.
#
# Usage:
# $ ./get_public_keys.bash >> ~/.ssh/authorized_keys

GITHUB_USER=${1:-"Thomasdezeeuw"}

echo "Getting $GITHUB_USER's key" >&2
curl "https://github.com/$GITHUB_USER.keys"
