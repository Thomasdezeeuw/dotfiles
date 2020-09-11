#!/usr/bin/env bash

set -eu

dst="$1"
src=${2:-"/"}

sudo rsync --archive --recursive \
	--safe-links --one-file-system \
	--no-perms --omit-dir-times --no-group --no-owner \
	--compress --compress-level=9 \
	--human-readable --progress "$src" "$dst"
