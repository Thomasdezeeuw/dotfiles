# Install

Installing Rust pre-commit and pre-push hooks.

```bash
cd $REPO/.git/hooks

# All version, checks a lot of targets
ln -s ~/.dotfiles/git_hooks/rust/hooks/pre-commit.all.bash pre-commit
ln -s ~/.dotfiles/git_hooks/rust/hooks/pre-push.all.bash pre-push

# Or the normal version, quite a bit quicker.
ln -s ~/.dotfiles/git_hooks/rust/hooks/pre-commit.bash pre-commit
ln -s ~/.dotfiles/git_hooks/rust/hooks/pre-push.bash pre-push
```
