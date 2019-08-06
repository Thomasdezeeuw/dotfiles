#
# # Bash settings
#

# Case-insensitive globbing (used in pathname expansion).
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it.
shopt -s histappend;

# Cd without "cd".
shopt -s autocd

# Make sure we clean up after ourselves.
shopt -s checkjobs

# Deal with resizing windows.
shopt -s checkwinsize

# Some convenience options, most of them are enabled by default.
shopt -s cmdhist
shopt -s dirspell
shopt -s dotglob
shopt -s expand_aliases
shopt -s extquote
shopt -s globstar

# Autocompletion.
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# Load the actual profile.
source ~/.dotfiles/profile/profile
