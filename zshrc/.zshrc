#!/usr/bin/env bash

# NOTE: Plugins that hold priority levels are numbered and ordered 
source ~/.config/zshrc/1-plugin-manager.sh
source ~/.config/zshrc/2-powershell10k.sh

source ~/.config/zshrc/aliases.sh
source ~/.config/zshrc/completions.sh
source ~/.config/zshrc/direnv.sh
source ~/.config/zshrc/fzf.sh
source ~/.config/zshrc/history.sh
source ~/.config/zshrc/homebrew.sh
source ~/.config/zshrc/path.sh
source ~/.config/zshrc/yazi.sh

eval $(thefuck --alias)

