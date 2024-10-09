#!/usr/bin/env bash

# FZF
# export FZF_DEFAULT_OPTS="--preview 'bat {}'"

export FZF_DEFAULT_COMMAND="fd --type file --hidden --follow --exclude .git --exclude .idea"
# export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"
# export FZF_CTRL_T_OPTS="--preview='less {}' --height=100% --bind shift-up:preview-page-up,shift-down:preview-page-down"

# --bind='ctrl-n:down+preview(bat {}),ctrl-p:up+preview(bat {})'
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# https://github.com/junegunn/fzf?tab=readme-ov-file#supported-commands
# TODO: Not working?
# _fzf_setup_completion path ag git kubectl
# _fzf_setup_completion dir tree

# ag didn't seem to work?
# export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -l -g ""'
# alias fzf="fzf --preview 'bat {}'"
#
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
# NOTE: don't use escape sequences here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# preview directorys content with eza when completing cd
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

function fzf_nvim() { 
  nvim "$(find . -type f -not -path '*/.*' | fzf)" 
}

function fzf_cd() { 
  cd "$(find . -type d -not -path '*/.*' | fzf)"; 
}

function fzf_cp() { 
  echo "$(find . -type f -not -path '*/.*' | fzf)" | pbcopy 
}

function _fzf_grep() {
  command rg --color=always --line-number --no-heading --smart-case "${*:-}" \
  | command fzf -d':' --ansi \
    --preview "command bat -p --color=always {1} --highlight-line {2}" \
    --preview-window ~8,+{2}-5 \
  | awk -F':' '{print $1}'
}

# Allows writing the result of _fzf_grep to both clipboard and print
function fzf_grep() {
  _fzf_grep | tee >(pbcopy)  >(cat) >/dev/null
}

function fzf_preview() {
  fzf --preview="bat {}"
}
