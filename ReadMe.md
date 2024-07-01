# Overview

Setup steps for a new

- [Overview](#overview)
- [Homebrew installation:](#homebrew-installation)
- [.zshrc](#zshrc)

## Homebrew installation

```bash
# Save all installed packages for new machine - aliased in ./zshrc/.zshrc
brew_leaves

# Installs previous packages into brew
xargs brew install < taps.txt
# We separate this step out because of ambiguous clashes such as dash formulae vs cask
xargs brew install --cask < casks.txt
```

## .zshrc

Z-Shell won't automatically check this directory for the config file.
You can sym-link with this command:

```sh
  ln -sf ~/.config/zshrc/.zshrc $HOME/.zshrc
  ln -sf ~/.config/lazygit/config.yml $HOME/Library/Application Support/lazygit/config.yml
```

Or it can be done via GNU Stow - which is installed as part of the [Homebrew Installation](#homebrew-installation):

```sh
  cd ~/.config
  stow zshrc
```
