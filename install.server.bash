#!/usr/bin/env bash

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
ln -v -s "`pwd`/git" "$HOME/.gitconfig"
mkdir -p "$HOME/.vim"
ln -v -s "`pwd`/vimrc" "$HOME/.vim/vimrc"

# Setup Vim-Plug.
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# Install all plugins.
vim +PlugInstall +qall

# Setup Tmux Plugin Manager.
mkdir -r ~/.tmux/plugins/tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# Install all plugins.
~/.tmux/plugins/tpm/scripts/install_plugins.sh
