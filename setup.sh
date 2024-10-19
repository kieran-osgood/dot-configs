#!/usr/bin/env bash

# macos defaults -
# See: https://macos-defaults.com/mission-control/expose-group-apps.html
# to script more of this automatically
function kill() {
	local process_name=$1

	if [ -z "$process_name" ]; then
		echo "Usage: wait_for_killall <process_name>"
		return 1
	fi

	# Start killall in the background
	killall "$process_name" &

	sleep 1

	echo "Restart: '$process_name' done."
}

## dock
echo "Configuring 'Dock'"
defaults write com.apple.dock "orientation" -string "left"
defaults write com.apple.dock expose-group-apps -bool true
defaults write com.apple.dock "tilesize" -int "45"
defaults write com.apple.dock "autohide" -bool "true"
defaults write com.apple.dock "autohide-time-modifier" -float "0"
defaults write com.apple.dock "autohide-delay" -float "0"
defaults write com.apple.dock "show-recents" -bool "false"

kill "Finder"

## finder
echo "Configuring 'Finder'"
defaults write com.apple.finder "AppleShowAllFiles" -bool "true"
defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true"
defaults write com.apple.finder "FXPreferredViewStyle" -string "Nlsv"
defaults write com.apple.finder "FXEnableExtensionChangeWarning" -bool "false"

## desktop
echo "Configuring 'Desktop'"
defaults write com.apple.finder "CreateDesktop" -bool "true"

kill "Finder"

## mouse
echo "Configuring 'Mouse'"
defaults write NSGlobalDomain com.apple.mouse.scaling -float "1"

## keyboard
echo "Configuring 'Keyboard'"
defaults write -g InitialKeyRepeat -int 15 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 2         # normal minimum is 2 (30 ms)
defaults write NSGlobalDomain "ApplePressAndHoldEnabled" -bool "false"
defaults write com.apple.HIToolbox AppleFnUsageType -int "0"

## mission control
echo "Configuring 'Mission Control'"
# This helps make windows not tiny when using mission control
# https://nikitabobko.github.io/AeroSpace/guide#a-note-on-mission-control
defaults write com.apple.dock "expose-group-apps" -bool "true"

kill "Dock"

# Other ------------------------------------------------------------------------------------------------------

### homebrew
echo "Configuring Homebrew"
xargs brew install <homebrew/taps.txt
brew install --cask nikitabobko/tap/aerospaekD40mRRTTT

xargs brew install --cask <homebrew/casks.txt

# Sets up the keybindings e.g. history with `CTRL-r`
$(brew --prefix)/opt/fzf/install

echo "Configuring sym links"
# Z-Shell won't automatically check this directory for the config file.
# You can sym-link with this command:
ln -sf ~/.config/zshrc/.zshrc $HOME/.zshrc
ln -sf ~/.config/vim/.vimrc $HOME/.vimrc
ln -sf ~/.config/vim/.ideavimrc $HOME/.ideavimrc
ln -sf ~/.config/lazygit/config.yml $HOME/Library/Application\ Support/lazygit/config.yml

# Terminal sudo brings up touch id
sudo cp /etc/pam.d/sudo_local.template /etc/pam.d/sudo_local
sed -i '' '3s/# //' /etc/pam.d/sudo_local

# sudo_local: local config file which survives system update and is included for sudo
# uncomment following line to enable Touch ID for sudo
# auth       sufficient     pam_tid.so

# Or it can be done via GNU Stow - which is installed as part of the [Homebrew Installation](#homebrew-installation):
#
# ```sh
#   cd ~/.config
#   stow zshrc
# ```
echo "Complete"
