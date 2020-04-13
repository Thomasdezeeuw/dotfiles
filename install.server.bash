#!/bin/bash

#
# # Make all required directories.
#

# User specific binary directory.
mkdir -v -p "$HOME/bin"

#
# # Linking
#

# Files that link to "~/.$file".
declare -a config_files=(
	"inputrc"
	"bash_profile"
	"tmux.conf"
	"zprofile"
)
for file in "${config_files[@]}"; do
	ln -v -s "`pwd`/$file" "$HOME/.$file"
done
ln -v -s "`pwd`/git" "$HOME/..gitconfig"
mkdir -p "$HOME/.vim"
ln -v -s "`pwd`/vimrc" "$HOME/.vim/vimrc"
