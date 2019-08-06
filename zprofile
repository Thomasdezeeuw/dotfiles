#
# # Zsh settings
#

# Export our preferred shell and shell options (used in Vim).
# TODO: get the full path, this isn't good enough.
export SHELL="zsh"
export SHELL_OPTS="-l"

#
# # Profile
#

# Load the actual profile.
source ~/.dotfiles/profile/profile

#
# # Prompt
#

# NOTE: this requires various functions found in the profile file sourced above.

precmd() {
	# Below is the same as in `prompt_command`.
	# FIXME: this first time this is called it always returns 1, which means we
	# start with a "failing" prompt.
	local EXIT=$?

	printf "\r\n"

	PS1="%f%k"

	if [ -n "$IN_VIM" ]; then
		PS1+="%F{#FFA500}vim "
	elif [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
		PS1+="%F{#FFA500}%n@%M "
	fi

	PS1+="%F{#5DC8FD}$(prompt_dir) "
	PS1+="%F{#6C6C6C}$(git_branch)"

	PS1+="%(?.%F{#62F592}.%F{#FC5D5B})λ%f%k "
}
