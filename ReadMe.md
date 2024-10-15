## Sketchybar

Forked the sketchybar setup from here: [Sketchybar with Aerospace setup](https://github.com/forteleaf/sketkchybar-with-aerospace)

## Setting up a new machine

Don't forget to submodule init for neovim

```sh
git submodule init
git submodule update
```

Run the setup script, this requires sudo due to editing file that sets up sudo -> touch id in terminal

```bash
./setup.sh
```

### Homebrew installation

> NOTE: `./setup.sh` will install the taps and casks on first install using

```bash
# Installs previous packages into brew
xargs brew install < homebrew/taps.txt

# We separate this step out because of ambiguous clashes such as dash formulae vs cask
xargs brew install --cask < homebrew/casks.txt
```

## Leaving a machine

```bash
# Save all installed packages for new machine - aliased in ./zshrc/.zshrc
brew_save
```

Check for git ignored settings in `~/.config`
Commit all up
