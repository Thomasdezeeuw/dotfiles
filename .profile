## Enviroment variables.

## Add user bin to path.
PATH=$PATH:$HOME/bin

# Go variables.
export GOROOT_BOOTSTRAP=$HOME/src/third_party/go1.8
export GOPATH=$HOME/go
export CGO_ENABLED=1
export GO15VENDOREXPERIMENT=1
export GOTRACEBACK=all
PATH=$PATH:$HOME/src/third_party/go/bin

# Node.
NODE_ENV=development

# Rust
#export RUST_BACKTRACE=1
PATH=$PATH:$HOME/.cargo/bin
RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

# To allow Rust openssl to be build.
# See https://github.com/sfackler/rust-openssl.
export OPENSSL_INCLUDE_DIR=`brew --prefix openssl`/include
export OPENSSL_LIB_DIR=`brew --prefix openssl`/lib

## CD Path.
# Allow for easier cd'ing around.
CDPATH=./:$HOME/src:$GOPATH/src/github.com/Thomasdezeeuw

# Neovim as the editor.
export EDITOR="nvim"
export VISUAL=$EDITOR
export GIT_EDITOR=$EDITOR
alias vim="nvim"
alias vi="nvim"

# Aliases
alias tmpdir="cd `mktemp -d`"

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
autocomplete_dir=`brew --prefix`/etc/bash_completion.d
if [ -d "$autocomplete_dir" ]; then
	for file in $autocomplete_dir/*; do
		. $file
	done
fi

# Pretty colors, yey!
export CLICOLOR=1

# Pretty command prompt, yey!
export PROMPT_COMMAND=prompt_command

function git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1) /'
}

function prompt_command() {
		# Get exit code from previous command, get this here
		# otherwise the command below will overwrite it.
		local EXIT="$?"

		PS1="\[\033[38;5;46m\]\u"    # Light Green username.
		PS1+="\[\033[38;5;15m\]@"    # White "@".
		PS1+="\[\033[38;5;33m\]\h"   # Blue hostname.
		PS1+="\[\033[38;5;15m\]:"    # White ":".
		PS1+="\[\033[38;5;208m\]\W " # Orange current directory.
		PS1+="\[\033[38;5;226m\]$(git_branch)" # Yellow git branch.

		if [ $EXIT != 0 ]; then
				PS1+="\[\033[38;5;160m\]✘ " # Red cross on failure.
		else
				PS1+="\[\033[38;5;46m\]✔ "  # Otherwise a green check mark.
		fi

		PS1+="\[\e[0m\]" # Reset colors.
}
