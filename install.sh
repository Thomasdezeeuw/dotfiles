#!/bin/bash

#
# # Make all required directories.
#

# User specific binary directory.
mkdir -v -p "$HOME/bin"
# Some source related directories.
mkdir -v -p "$HOME/src/notes"
mkdir -v -p "$HOME/src/third_party"
mkdir -v -p "$HOME/src/scripts"
# Required for go.
mkdir -v -p "$HOME/go/src/github.com"

#
# # Linking
#

# Link the directories required by go.
ln -v -s "$HOME/bin" "$HOME/go/bin"
ln -v -s "$HOME/src/go" "$HOME/go/src/github.com/Thomasdezeeuw"

# Link all local files to the config directory.
declare -a config_files=(
	"git"
	"i3"
)

for file in "${config_files[@]}"; do
	mkdir -p "$HOME/.config/$file"
	ln -v -L "$file" "$HOME/.config/$file/config"
done

echo "Required by install:
	- source .dotfiles/profile/profile, see bash_profile.

Languages:
	- Rust (and Cargo): https://www.rust-lang.org/en-US/install.html,
	- Go: https://golang.org/dl,
	- C: Gcc/Clang.

Tools:
	- Git,
	- Exa 'cargo install exa',
	- Ripgrep: 'cargo install ripgrep',
	- fd: 'cargo install fd-find',
	- Clippy: 'cargo install clippy',
	- Racer: 'cargo install racer',
	- Vim,
	- Vim plugins: https://github.com/junegunn/vim-plug,
	- Make,
	- CMake,
	- Sqlite,
	- Valgrind.

SSH:
	- Generate new keys, add to GitHub for easy pushing,
	- Check ~/.ssh/config.

Misc:
	- Fira Code font (https://github.com/tonsky/FiraCode)."
