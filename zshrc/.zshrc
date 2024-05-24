# Note to future self - this wont be auto detected by zsh
# so you will want to add a symlink to it 
# `ln -sf ~/.config/zshrc/.zshrc $HOME/.zshrc`
eval "$(starship init zsh)"
eval "$(direnv hook zsh)"

eval "$(zoxide init zsh)"
alias cat="bat"
alias ls="exa"
alias z="zoxide"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# stolen from user "alexreg" above in this issue
# https://github.com/direnv/direnv/issues/68#issuecomment-1003426550
copy_function() {
  test -n "$(declare -f "$1")" || return
  eval "${_/$1/$2}"
}
copy_function _direnv_hook _direnv_hook__old
_direnv_hook() {
  # old line
  #_direnv_hook__old "$@" 2> >(grep -E -v '^direnv: (export)')

  # my new line
  _direnv_hook__old "$@" 2> >(awk '{if (length >= 10) { sub("^direnv: export.*","direnv: export "NF" environment variables")}}1')

  # as suggested by user "radekh" above
  wait

  # as suggested by user "Ic-guy" below if you're using bash > v4.4
  # throws error for me on zsh
  # wait $!
}

# source ~/Git/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
# export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="spaceship"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="dd/mm/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# plugins=(git zsh-nvm zsh-autosuggestions asdf)
# plugins=()

# source $ZSH/oh-my-zsh.sh

# User configuration

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# alias ipconfigpublic="curl ipecho.net/plain ; echo"
# alias ipconfiglocal="ifconfig |grep inet"
# alias dsa="docker stop $(docker ps -aq)"
# alias pip=/usr/bin/pip3

# Git
alias ga="git add"
alias gaa="git add ."
alias gc="git commit -m"
alias gcnv="git commit --no-verify -m"
alias gp="git push"
alias gy="git pull"
alias gs="git status"
alias prune="git branch --merged | egrep -v \"(^\*|master|main|dev|develop|development)\" | xargs git branch -d"
alias amend="git commit --amend --no-edit"


# Neovim
alias nv="neovide"
alias vim="nvim"
alias vi="nvim"

# React Native
# alias watchman="watchman watch-del-all; rm -rf $TMPDIR/react-native-packager-cache-; rm -rf $TMPDIR/metro-bundler-cache-; rm -rf node_modules/; npm cache clean --force; npm i; npm run start"
# alias fl="bundle exec fastlane"
# alias rn_clean="watchman watch-del-all; rm -rf /tmp/metro-*; npm cache clean --force; rm -rf node_modules ios/Pods; yarn; npx pod-install; yarn start --reset-cache"
# alias simulators="xcrun simctl list"
# alias iphone8="npx react-native run-ios --simulator=\"iPhone 8\""
# alias ipad="npx react-native run-ios --simulator=\"iPad Pro (9.7-inch)\""
# alias iphonese="npx react-native run-ios --simulator=\"iPhone SE (3rd generation)\""
# alias iphonemini="npx react-native run-ios --simulator=\"iPhone 13 mini\""
# alias flame="react-devtools"
# alias booted="xcrun simctl list devices booted"

# Mouse buttons not working? lets see if its warp
# mouse() {
#   # sudo launchctl stop com.apple.loginwindow
#   # sleep 2
#   # sudo launchctl start com.apple.loginwindow

#   # ioreg -l -d 1 -w 0 | grep SecureInput
#   # Is warp the culprit?
#   # ioreg -l -d 1 -w 0 | grep -o 'kCGSSessionSecureInputPID\"=(\d*)'
#   ioreg -l -d 1 -w 0 | grep -o 'kCGSSessionSecureInputPID"=\d*' | grep -o '\d*'
#   ps -ax | grep warp
# # grep "IOHDIXHDDriveInKernel"=0" -o 'IOHDIXHDDriveInKernel"=[^"]'
# }


# START - Ruby Setup
# export PATH=/opt/homebrew/opt/ruby/bin:/opt/homebrew/lib/ruby/gems/3.0.0/bin:$PATH
# export LDFLAGS="-L/opt/homebrew/opt/ruby/lib"
# export CPPFLAGS="-I/opt/homebrew/opt/ruby/include"
# END

# export JAVA_8_HOME=$(/usr/libexec/java_home -v1.8)
# export JAVA_11_HOME=$(/usr/libexec/java_home -v11)
# alias java8='export JAVA_HOME=$JAVA_8_HOME'
# alias java11='export JAVA_HOME=$JAVA_11_HOME'
# java11 # default to Java 11
# END

# export DOCKERHUB_PASSWORD=nmb3eub5kek1JCU-qpm

# mozilla/SOPS # Authenticates via KMS
# export SOPS_KMS_ARN="arn:aws:kms:us-east-1:345637428723:key/3814acaa-8aaf-42e9-af3b-bbd3d5b02e39"

# START - Terraform 
# autoload -U +X bashcompinit && bashcompinit
# complete -o nospace -C /opt/homebrew/bin/terraform terraform
# END

# export EAS_AC_ZSH_SETUP_PATH=/Users/kieranosgood/Library/Caches/eas-cli/autocomplete/zsh_setup && test -f $EAS_AC_ZSH_SETUP_PATH && source $EAS_AC_ZSH_SETUP_PATH; # eas autocomplete setup

# export STORE_PASSWORD="letmein"
# export KEY_ALIAS="punchline"
# export KEY_PASSWORD="letmein"

# export SSH_KEY="LS0tLS1CRUdJTiBQUklWQVRFIEtFWS0tLS0tCk1GTUNBUUV3QlFZREsyVndCQ0lFSU54TmlGQVNRRUxtSXp1YWJ3cTYrT1pDdW1va1BVNFphR25Ib3BWVFhWdm0Kb1NNRElRQ3k5Sm9YTGZMaTNCT2RsZjNqMmlEeG9nYnlEMVRPem1DOGlPQkRUbWlVYXc9PQotLS0tLUVORCBQUklWQVRFIEtFWS0tLS0tCg=="
# export SSH_PHRASE=""

# disable autocorrect
 unsetopt correct_all

# tabtab source for packages
# [[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true

# START - Path variables
  export PATH=~/.npm-global/bin:$PATH
  export PATH="$PATH:/Users/kieranosgood/.dotnet/tools"
  export PATH=$PATH:/usr/share/php/bin
  export PATH=$PATH:$HOME/.fastlane/bin

  # Homebrew
  export PATH=/opt/homebrew/bin:$PATH

  # pnpm
  export PNPM_HOME="/Users/kieranosgood/Library/pnpm"
  export PATH="$PNPM_HOME:$PATH"
  # pnpm end

  # START - Android studio/development setup
  export ANDROID_HOME=$HOME/Library/Android/sdk
  export PATH=$PATH:$ANDROID_HOME/emulator
  export PATH=$PATH:$ANDROID_HOME/tools
  export PATH=$PATH:$ANDROID_HOME/tools/bin
  export PATH=$PATH:$ANDROID_HOME/platform-tools
  # END - Android
 
  PATH="$PATH:/Applications/WezTerm.app/Contents/MacOS"

  # Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
  export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
  export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
  export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"
  export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig"


  # !!!MUST BE LAST!!!
  export PATH="$PATH:$HOME/.rvm/bin"

# END 

# eval "$(fnm env --use-on-cd)"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
# export SDKMAN_DIR="$HOME/.sdkman"
# [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
# eval 

# alias pn=pnpm

# bun completions
# [ -s "/Users/kieranosgood/.bun/_bun" ] && source "/Users/kieranosgood/.bun/_bun"

# bun
# export BUN_INSTALL="$HOME/.bun"
# export PATH="$BUN_INSTALL/bin:$PATH"

nixify() {
  if [ ! -e ./.envrc ]; then
    echo "use nix" > .envrc
    direnv allow
  fi
  if [[ ! -e shell.nix ]] && [[ ! -e default.nix ]]; then
    cat > default.nix <<'EOF'
with import <nixpkgs> {};
mkShell {
  nativeBuildInputs = [
    bashInteractive
  ];
}
EOF
    ${EDITOR:-vim} default.nix
  fi
}

flakify() {
  if [ ! -e flake.nix ]; then
    nix flake new -t github:nix-community/nix-direnv .
  elif [ ! -e .envrc ]; then
    echo "use flake" > .envrc
    direnv allow
  fi
  ${EDITOR:-vim} flake.nix
}
