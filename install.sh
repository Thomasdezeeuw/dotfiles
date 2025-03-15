#!/usr/bin/env sh

set -eu

#
# # Make all required directories.
#

# User specific binary directory.
mkdir -v -p "$HOME/bin"

#
# # Linking
#

# Link all local files to the config directory.
declare -a config_files=(
	"git"
	"i3"
	"i3status"
)

for file in "${config_files[@]}"; do
	mkdir -p "$HOME/.config/$file"
	ln -v -s "`pwd`/$file" "$HOME/.config/$file/config"
done

# Files that link to "~/.$file".
declare -a home_files=(
	"inputrc"
	"bashrc"
	"tmux.conf"
	"zprofile"
)
this_dir="$HOME/.dotfiles"
for file in "${home_files[@]}"; do
	ln -v -s "$this_dir/$file" "$HOME/.$file"
done

mkdir -p "$HOME/.vim"
ln -v -s "$this_dir/vimrc" "$HOME/.vim/vimrc"
ln -v -s "$this_dir/vim_ycm_conf.py" "$HOME/.vim/vim_ycm_conf.py"

# Setup Vim-Plug.
curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# Install all plugins.
vim +PlugInstall +qall

# Setup Tmux Plugin Manager.
mkdir -p "$HOME/.tmux/plugins/tpm"
git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
# Install all plugins.
TMUX_PLUGIN_MANAGER_PATH="$HOME/.tmux/plugins/" "$HOME/.tmux/plugins/tpm/scripts/install_plugins.sh"


echo "Required by install:
	- source .dotfiles/profile/profile, see bashrc.

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
	- diffr: 'cargo install diffr',
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

