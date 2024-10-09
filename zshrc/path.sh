#!/usr/bin/env bash

# START - Path variables
export PATH=~/.npm-global/bin:$PATH
export PATH=/opt/homebrew/bin:$PATH
PATH="$PATH:/Applications/WezTerm.app/Contents/MacOS"

# pnpm
export PNPM_HOME="/Users/kieranosgood/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

# START - Android studio/development setup
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
# !!!MUST BE LAST!!!
export PATH="$PATH:$HOME/.rvm/bin"

# END
