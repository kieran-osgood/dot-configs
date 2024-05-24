# .zshrc

Z-Shell won't automatically check this directory for the config file.
You can sym-link with this command:

```sh
  ln -sf ~/.config/zshrc/.zshrc $HOME/.zshrc
```

Install GNU stow (might be useful if we do more of this):

```sh
  brew install stow
```

Then link the file:

```sh
  cd ~/.config
  stow zshrc
```
