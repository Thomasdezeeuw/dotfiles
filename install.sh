#!/bin/bash

#
# # Make all required directories.
#

# Required directories.
mkdir -v -p ~/bin ~/src ~/go/src/github.com

# Directories for sources of different languages.
declare -a src_dirs=(
	"go"
	"haskell"
	"js"
	"rust"
	"scripts"
	"third_party"
	"websites"
)

for file in "${src_dirs[@]}"; do
	mkdir -v -p "$HOME/src/$file"
done

#
# # Linking
#

# Link the directories required by go.
ln -v -s ~/bin ~/go/bin
ln -v -s ~/src/go ~/go/src/github.com/Thomasdezeeuw

# Link all local files to the home directory.
declare -a files_to_link=(
	"bash_profile"
	"editorconfig"
	"gitconfig"
	"npmrc"
	"vimrc"
)

for file in "${files_to_link[@]}"; do
	ln -v $file ~/.$file
done

# Link i3 configuration.
mkdir -p ~/.config/.i3
ln -v i3 ~/.config/i3/config

echo "Required by install:
	- Rust (and Cargo): https://www.rust-lang.org/en-US/install.html,
	- Go: https://golang.org/dl,
	- Gcc,
	- Clang (llvm),
	- Node.js.

Tools:
	- Git,
	- Exa 'cargo install exa',
	- Ripgrep: 'cargo install ripgrep',
	- Clippy: 'cargo install clippy',
	- Vim,
	- Vim plugins: https://github.com/junegunn/vim-plug,
	- Make,
	- CMake,
	- Sqlite,
	- Valgrind.

SSH:
	- Setup SSH server, including for public key only auth,
	- Generate new keys, add to GitHub for easy pushing,
	- Add local public to authorized keys,
	- Check ~/.ssh/config."
