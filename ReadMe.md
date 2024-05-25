# Overview

Setup steps for a new

- [Overview](#overview)
- [Homebrew installation:](#homebrew-installation)
- [.zshrc](#zshrc)

## Homebrew installation

```bash
# Save all installed packages for new machine
brew leaves > ~/.config/homebrew/leaves.txt

# Installs previous packages into brew
xargs brew install < leaves.txt
```

## .zshrc

Z-Shell won't automatically check this directory for the config file.
You can sym-link with this command:

```sh
  ln -sf ~/.config/zshrc/.zshrc $HOME/.zshrc
```

Or it can be done via GNU Stow - which is installed as part of the [Homebrew Installation](#homebrew-installation):

```sh
  cd ~/.config
  stow zshrc
```
