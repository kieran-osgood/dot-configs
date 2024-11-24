#!/usr/bin/env bash

autoload -U compinit
compinit
# zoxide init must come after compinit
eval "$(zoxide init zsh)"

# Completions
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# bun completions
[ -s "/Users/kieranosgood/.bun/_bun" ] && source "/Users/kieranosgood/.bun/_bun"
