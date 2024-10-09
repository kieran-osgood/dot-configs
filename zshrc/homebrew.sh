#!/usr/bin/env bash

# Adds temrinal completions for all homebrew clis
# e.g. aerospace
if type brew &>/dev/null; then
	FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

	autoload -Uz compinit
	compinit
fi

function brew_save {
	brew leaves >~/.config/homebrew/taps.txt
	brew list --casks >~/.config/homebrew/casks.txt
	echo "Complete"
}
