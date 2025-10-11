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
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
# END

export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="/opt/homebrew/lib/ruby/gems/3.4.0/bin:$PATH"
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# bun completions
export PATH="/Users/kieranosgood/.bun/bin:$PATH"
[ -s "/Users/kieranosgood/.bun/_bun" ] && source "/Users/kieranosgood/.bun/_bun"
export PATH="$HOME/.local/bin:$PATH"
