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

# Export our preferred shell and shell options (used in Vim).
export SHELL="$0"
export SHELL_OPTS="-l"

# Autocompletion.
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

#
# # Profile
#

# Load the actual profile.
source ~/.dotfiles/profile/profile

#
# # Prompt
#

# NOTE: this requires various functions found in the profile file sourced above.

# Set the foreground to a rgb color. Call syntax: `fg_color r255 g255 b255`.
fg_color() {
	printf "\[\x1b[38;2;$1;$2;$3m\]"
}

# The actual prompt.
prompt_command() {
	# Get exit code from previous command, get this here otherwise the commands
	# below will overwrite it.
	local EXIT=$?

	# Print a new line.
	printf "\r\n"

	# Start by resetting the colours.
	PS1="\[\e[0m\]"

	if [ -n "$IN_VIM" ]; then
		# Show that we're inside Vim.
		PS1+="$(fg_color 255 165 0)vim "
	elif [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
		# Show orange username@hostname, if in a ssh session.
		PS1+="$(fg_color 255 165 0)\u@\h "
	fi

	PS1+="$(fg_color 93 200 253)$(prompt_dir) " # Blue directory.
	PS1+="$(fg_color 108 108 108)$(git_branch)" # Grey git branch, if in a repo.

	# Red on failure of the previous command, green otherwise.
	if [ $EXIT != 0 ]; then
		PS1+="$(fg_color 252 93 91)"
	else
		PS1+="$(fg_color 98 245 146)"
	fi
	PS1+="λ\[\e[0m\] " # A lambda and reset the colors.
}

export PROMPT_COMMAND=prompt_command
