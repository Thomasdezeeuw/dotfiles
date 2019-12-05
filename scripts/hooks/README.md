# Install

Installing Rust pre-commit and pre-push hooks.

```bash
cd $REPO/.git/hooks

ln -s ~/.dotfiles/scripts/hooks/rust.pre-commit.bash pre-commit
ln -s ~/.dotfiles/scripts/hooks/rust.pre-push.bash pre-push
```
