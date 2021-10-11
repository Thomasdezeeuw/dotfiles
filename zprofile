# Location: ~/.zprofile

#
# # Zsh settings
#

# Export our preferred shell and shell options (used in Vim).
if [ -z "${SHELL+x}" ]; then export SHELL="zsh"; fi

# Load the actual profile.
source ~/.dotfiles/profile/profile

# Autocompletion.
# NOTE: must be run after loading profile, because otherwise `brew` might not be
# found.
if type brew &>/dev/null; then
	FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

	autoload -Uz compinit
	compinit
fi

#
# # Profile
#

#
# # Prompt
#

# NOTE: this requires various functions found in the profile file sourced above.

precmd() {
	# See below why we redefine `precmd`.
	precmd() {
	# Below is the same as in `prompt_command`.
	local EXIT=$?

	# Print a new line.
	printf "\r\n"

	# Start by resetting the colours.
	PS1="%f%k"

	# Show when we're inside Vim.
	if [ -n "$IN_VIM" ]; then
		PS1+="%F{#FFA500}vim "
	fi
	# Show orange username@hostname, if in a ssh session.
	if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
		PS1+="%F{#FFA500}%n@%M "
	fi

	PS1+="%F{#5DC8FD}$(prompt_dir) " # Blue directory.
	if in_git_repo; then
		# Orange pencil if the git tree is dirty.
		if ! is_tree_clean; then
			PS1+="%F{#EDA804} "
		fi
		PS1+="%F{#6C6C6C}$(git_branch)" # Grey git branch, if in a repo.
	fi

	# Red on failure of the previous command, green otherwise.
	if [ $EXIT != 0 ]; then
		PS1+="%F{#FC5D5B}"
	else
		PS1+="%F{#62F592}"
	fi
	PS1+="λ%f%k " # A lambda and reset the colors.
	}

	# In the first call to `precmd` `$?` returns 1, indicating an failure, but
	# this is clearly bs. So we call `true` to set the exit code to 0 and call
	# the newly redefined `precmd`.
	true
	precmd
}
