#!/usr/bin/env bash

# Better overrides for basics
export BAT_OPTS="--color=always --style=numbers --theme=ansi"
alias lg="lazygit"
alias cat="bat"
alias ls="eza"
# alias cd="z"
alias zw="zellij --layout welcome"

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

# Editors
export EDITOR=nvim
alias zshrc="nvim ~/.zshrc"
alias dot="cd ~/.config && nvim ."
alias vi="pf --print0 | xargs -0 -o nvim"
# alias storm="/Users/kieranosgood/Applications/WebStorm.app/Contents/MacOS/webstorm"
# alias webstorm="/Users/kieranosgood/Applications/WebStorm.app/Contents/MacOS/webstorm"

alias p=pnpm
alias pn=pnpm

# # React Native
# alias simulators="xcrun simctl list"
# alias ipad="npx react-native run-ios --simulator=\"iPad Pro (9.7-inch)\""
# alias iphonese="npx react-native run-ios --simulator=\"iPhone SE (3rd generation)\""
# alias iphonemini="npx react-native run-ios --simulator=\"iPhone 13 mini\""
# alias booted="xcrun simctl list devices booted"

# tmux
alias zj="zellij"
alias zjw="zellij -l welcome"
