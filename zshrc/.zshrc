eval "$(direnv hook zsh)" # Useful for shell.nix

# Enable vim mode
bindkey -v

alias zshrc="nvim ~/.zshrc"
alias dot="cd ~/.config && nvim ."

function brew_leaves {
  brew leaves > ~/.config/homebrew/taps.txt
  brew list --casks > ~/.config/homebrew/casks.txt
  echo "Complete"
}
alias brew_leaves=brew_leaves

# Plugin Manager
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
# TODO: May not need the clone as we have it in leaves on homebrew
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
zinit ice depth=1; zinit light romkatv/powerlevel10k

export BAT_OPTS="--color=always --style=numbers"

# FZF
# export FZF_DEFAULT_OPTS="--preview 'bat {}'"

export FZF_DEFAULT_COMMAND="fd --type file --hidden --follow --exclude .git --exclude .idea"
# export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"
export FZF_CTRL_T_OPTS="--preview='less {}' --height=100% --bind shift-up:preview-page-up,shift-down:preview-page-down"

# --bind='ctrl-n:down+preview(bat {}),ctrl-p:up+preview(bat {})'
# export FZF_CTRL_T_OPTS="
#   --walker-skip .git,node_modules,target
#   --preview 'bat {}'
#   --bind 'ctrl-/:change-preview-window(down|hidden|)'"
alias pf='fzf --preview="bat {}"'

# https://github.com/junegunn/fzf?tab=readme-ov-file#supported-commands
# TODO: Not working?
# _fzf_setup_completion path ag git kubectl
# _fzf_setup_completion dir tree

# ag didn't seem to work?
# export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -l -g ""'
# alias fzf="fzf --preview 'bat {}'"
#
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

zinit light Aloxaf/fzf-tab

# Completions
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# History
# ctl + r - fzf show history
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# zinit snippet OMZP::1password
zinit snippet OMZP::git
zinit snippet OMZP::command-not-found
zinit snippet OMZP::sudo

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
# NOTE: don't use escape sequences here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'

# Lowercase path matching in `cd` etc
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors '${(s.:.)LS_COLORS}'
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'

autoload -U compinit; compinit

# Direnv
# This cleans up the direnv output / nix shell starting environment variables
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

alias c="clear"
alias cat="bat"
alias ls="exa"
alias cd="z"

# Dirs
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

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
export EDITOR=nvim
export VISUAL="nvr --remote-wait +'set bufhidden=wipe'"

alias nv="neovide"
alias vim="nvim"
alias vi="pf --print0 | xargs -0 -o nvim"
alias storm="/Users/kieranosgood/Applications/WebStorm.app/Contents/MacOS/webstorm"
alias webstorm="/Users/kieranosgood/Applications/WebStorm.app/Contents/MacOS/webstorm"

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

# Ruby Setup
# export PATH=/opt/homebrew/opt/ruby/bin:/opt/homebrew/lib/ruby/gems/3.0.0/bin:$PATH
# export LDFLAGS="-L/opt/homebrew/opt/ruby/lib"
# export CPPFLAGS="-I/opt/homebrew/opt/ruby/include"

# Java
# export JAVA_8_HOME=$(/usr/libexec/java_home -v1.8)
# export JAVA_11_HOME=$(/usr/libexec/java_home -v11)
# alias java8='export JAVA_HOME=$JAVA_8_HOME'
# alias java11='export JAVA_HOME=$JAVA_11_HOME'
# java11 # default to Java 11

# export DOCKERHUB_PASSWORD=

# mozilla/SOPS # Authenticates via KMS
# export SOPS_KMS_ARN="arn:aws:kms:us-east-1:<>:key/<>"

# START - Terraform 
# autoload -U +X bashcompinit && bashcompinit
# complete -o nospace -C /opt/homebrew/bin/terraform terraform
# END

# START - Path variables
  export PATH=~/.npm-global/bin:$PATH
  export PATH="$PATH:/Users/kieranosgood/.dotnet/tools"
  export PATH=$PATH:/usr/share/php/bin
  export PATH=$PATH:$HOME/.fastlane/bin

  # Homebrew
  export PATH=/opt/homebrew/bin:$PATH

  # pnpm
  alias pn=pnpm
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

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
# export SDKMAN_DIR="$HOME/.sdkman"
# [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
# eval 

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

cx() { cd "$@" && l; }
fcd() { cd "$(find . -type d -not -path '*/.*' | fzf)" && l; }
f() { echo "$(find . -type f -not -path '*/.*' | fzf)" | pbcopy }
fv() { nvim "$(find . -type f -not -path '*/.*' | fzf)" }

# Usage: rgfzf [<rg SYNOPSIS>]
function fg {
  command rg --color=always --line-number --no-heading --smart-case "${*:-}" \
  | command fzf -d':' --ansi \
    --preview "command bat -p --color=always {1} --highlight-line {2}" \
    --preview-window ~8,+{2}-5 \
  | awk -F':' '{print $1}'
}

eval "$(zoxide init zsh)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Disabled due to direnv printing output on cd
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

