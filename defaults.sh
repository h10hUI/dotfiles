#!/bin/bash -e

defaults write -g NSAutomaticWindowAnimationsEnabled -bool false
defaults write -g NSDocumentRevisionsWindowTransformAnimation -bool false
defaults write -g NSInitialToolTipDelay -integer 0
defaults write -g NSWindowResizeTime 0.1
defaults write -g QLPanelAnimationDuration -float 0.15
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"
defaults write NSGlobalDomain InitialKeyRepeat -int 9
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool NO
defaults write NSGlobalDomain com.apple.springing.delay -float 0
defaults write NSGlobalDomain com.apple.springing.enabled -bool true
defaults write com.apple.CrashReporter DialogType -string "none"
defaults write com.apple.LaunchServices LSQuarantine -bool false
defaults write com.apple.dashboard mcx-disabled -bool true
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0
defaults write com.apple.dock expose-animation-duration -float 0
defaults write com.apple.dock mineffect suck
defaults write com.apple.finder AnimateInfoPanes -boolean false
defaults write com.apple.finder AnimateWindowZoom -bool false
defaults write com.apple.finder AppleShowAllFiles YES
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
defaults write com.apple.finder QLEnableTextSelection -bool true
defaults write com.apple.finder QLHidePanelOnDeactivate -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder ShowTabView -bool true
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
defaults write com.apple.finder _FXSortFoldersFirst -bool true
defaults write com.apple.screencapture disable-shadow -bool true
defaults write com.apple.screencapture type -string "jpg"
defaults write com.apple.terminal StringEncodings -array 4

echo "$(tput setaf 2)Initialize defaults settings complete! :)$(tput sgr0)"
