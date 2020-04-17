#!/usr/bin/env bash

set -eu

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
this_dir="$HOME/.dotfiles"
for file in "${config_files[@]}"; do
	ln -v -s "$this_dir/$file" "$HOME/.$file"
done
ln -v -s "$this_dir/git" "$HOME/.gitconfig"
mkdir -p "$HOME/.vim"
ln -v -s "$this_dir/vimrc" "$HOME/.vim/vimrc"

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
