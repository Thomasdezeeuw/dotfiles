#!/bin/sh

#
# # Make all required directories.
#

mkdir -v -p \
	~/bin \  # Location for binaries.
	~/go \   # Required by the go tool.
	~/.Trash # For the `trash` command.

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

for dir in "${src_dirs[@]}"; do
	mdir -v -p "~/src/$dir"
done

#
# # Linking
#

# Link the directories required by go.
ln -v ~/go/bin ~/bin
ln -v ~/go/src/github.com/Thomasdezeeuw ~/src/go

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

echo "Requires by install: \
	- Rust (and Cargo): https://www.rust-lang.org/en-US/install.html, \
	- Go: https://golang.org/dl, \
	- Exa `cargo install exa`, \
	- Ripgrep: `cargo install ripgrep`, \
	- Clippy: `cargo install clippy`, \
	- Vim, \
	- Vim plugins: https://github.com/junegunn/vim-plug, \
	- Make, \
	- Gcc, \
	- Clang (llvm), \
	- Node.js, \
	- Sqlite, \
	- Valgrind."
