# Overview

Setup steps for a new

- [Overview](#overview)
- [Homebrew installation:](#homebrew-installation)
- [.zshrc](#zshrc)

# Clone

```
git submodule init
git submodule update
```

## Mac os settings to override

keyboard repeat rate

```
defaults write -g InitialKeyRepeat -int 15 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 2 # normal minimum is 2 (30 ms)

```

## Homebrew installation

```bash
# Save all installed packages for new machine - aliased in ./zshrc/.zshrc
brew_save

# Installs previous packages into brew
xargs brew install < homebrew/taps.txt

# We separate this step out because of ambiguous clashes such as dash formulae vs cask
xargs brew install --cask < homebrew/casks.txt
```

## Sketchybar

https://github.com/forteleaf/sketkchybar-with-aerospace

## FZF

Sets up the keybindings e.g. history with `CTRL-r`

```sh
$(brew --prefix)/opt/fzf/install
```

## .zshrc

Z-Shell won't automatically check this directory for the config file.
You can sym-link with this command:

```sh
  ln -sf ~/.config/zshrc/.zshrc $HOME/.zshrc
  ln -sf ~/.config/lazygit/config.yml $HOME/Library/Application\ Support/lazygit/config.yml
```

Or it can be done via GNU Stow - which is installed as part of the [Homebrew Installation](#homebrew-installation):

```sh
  cd ~/.config
  stow zshrc
```
