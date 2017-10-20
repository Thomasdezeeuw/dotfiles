## Enviroment variables.

# Add user bin to path.
PATH=$HOME/bin:$PATH

# Shell variable for Neovim.
export SHELL="/usr/local/bin/bash -il"

# Go
export GOROOT_BOOTSTRAP=$HOME/src/third_party/go1.9
export GOPATH=$HOME/go
export CGO_ENABLED=1
export GO15VENDOREXPERIMENT=1
export GOTRACEBACK=all
PATH=$PATH:$HOME/src/third_party/go/bin

# Node
NODE_ENV=development

# Rust
PATH=$PATH:$HOME/.cargo/bin
export RUST_BACKTRACE=full
export CARGO_INCREMENTAL=1
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

# Haskell
PATH=$PATH:$HOME/Library/Haskell/bin

# Neovim as the editor.
export EDITOR="vim"
export VISUAL=$EDITOR
export GIT_EDITOR=$EDITOR

# Aliases
alias tmpdir="cd `mktemp -d`"
alias trash="rmtrash"
alias q="exit"
alias ls="exa"
alias gcc="gcc-7"
alias vim="vim -p" # Open each file in a seprate tab.

rustr() {
	local SRC_FILE=$1
	local BIN=${1%???}
	rustc $SRC_FILE && ./$BIN
	/bin/rm $BIN
}

# Overwrites the `rm` command.
rm() {
	echo "Did you mean 'trash $@'?"
}

# Use clang as C compiler, rather then a fake gcc (which is clang as well).
CC=clang

# Bad Homebrew.
export HOMEBREW_NO_ANALYTICS=1

# Boring language stuff.
export LANG="en_US.UTF-8";
export LC_ALL="en_US.UTF-8";

# Case-insensitive globbing (used in pathname expansion).
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it.
shopt -s histappend;

# Autocompletion.
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# Pretty colors, yey!
export CLICOLOR=1

# Pretty command prompt, yey!
export PROMPT_COMMAND=prompt_command

function git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1) /'
}

function prompt_command() {
	# Get exit code from previous command, get this here
	# otherwise the commands below will overwrite it.
	local EXIT="$?"

	# Get the git root, defaulting to nothing.
	GIT_DIR="$(git rev-parse --show-toplevel 2>&1)"
	if [ $? != 0 ]; then
		GIT_DIR=""
	fi

	# Remove the last directory from the path.
	TRIM_DIR="$(echo $GIT_DIR | rev | cut -d'/' -f2- | rev)"
	# Set the directory to the current directory, removing everything before the
	# root of the git project.
	PWD=$(pwd -P)
	DIR=${PWD#${TRIM_DIR}}
	DIR="${DIR/$HOME/\~}"
	DIR=${DIR:1}

	# Wether or not the git directory is dirty.
	GIT_DIRTY="$(git status --porcelain 2>/dev/null)"

	# Red arrow failure, other a green arrow.
	if [ $EXIT != "0" ]; then
		PS1="\[\033[38;5;160m\]➜ "
	else
		PS1="\[\033[38;5;46m\]➜ "
	fi
	# Blue directory; either based on the git root directory or
	# based on the home directory, trimming anything before either of them.
	PS1+="\[\033[38;5;39m\]$DIR "
	# Light blue color to indicate a clean branch, or yellow for dirty one.
	if [ -z "$GIT_DIRTY" ]; then
		PS1+="\[\033[38;5;87m\]$(git_branch)"
	else
		PS1+="\[\033[38;5;226m\]$(git_branch)"
	fi
	PS1+="\[\e[0m\]" # Reset colors.
	PS1+="λ "
}
