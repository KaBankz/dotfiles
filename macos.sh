#!/usr/bin/env bash

# MacOS settings
# ref: https://macos-defaults.com
# ref: https://mths.be/macos

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# ---------------------------------- GENERAL --------------------------------- #
# Disable the creation of .DS_Store files on network volumes and removable media
defaults write com.apple.desktopservices "DSDontWriteNetworkStores" -bool "true"
defaults write com.apple.desktopservices "DSDontWriteUSBStores" -bool "true"

# disable richtext in textedit
defaults write com.apple.TextEdit "RichText" -bool "false"

killall TextEdit

# --------------------------------- KEYBOARD --------------------------------- #
# Disable long press for special characters
defaults write -g ApplePressAndHoldEnabled -bool "false"
# Make key repeat faster
defaults write -g InitialKeyRepeat -int "15"
defaults write -g KeyRepeat -int "2"

# ------------------------------ MOUSE/TRACKPAD ------------------------------ #
# Enable linux like window dragging (drag windows from anywhere, not just titlebar)
# with CTRL+CMD+Drag
defaults write -g NSWindowShouldDragOnGesture -bool "true"
# Set mouse speed to 1.5
defaults write NSGlobalDomain com.apple.mouse.scaling -float "1.5"
# Enable 3 finger drag
defaults write com.apple.AppleMultitouchTrackpad "TrackpadThreeFingerDrag" -bool "true"
defaults write com.apple.AppleMultitouchTrackpad "TrackpadThreeFingerHorizSwipeGesture" -int "0"
defaults write com.apple.AppleMultitouchTrackpad "TrackpadThreeFingerVertSwipeGesture" -int "0"

# ---------------------------------- FINDER ---------------------------------- #
# Show all file extensions in Finder
defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true"
# Show all hidden files in Finder
defaults write com.apple.finder "AppleShowAllFiles" -bool "true"
# Show path bar in Finder
defaults write com.apple.finder "ShowPathbar" -bool "true"
# Keep folders first when sorting
defaults write com.apple.finder "_FXSortFoldersFirst" -bool "true"
# Search current folder by default
defaults write com.apple.finder "FXDefaultSearchScope" -string "SCcf"

killall Finder

# ----------------------------------- DOCK ----------------------------------- #
# Set window minimize effect to scale
defaults write com.apple.dock "mineffect" -string "scale"
# Set dock icon size
defaults write com.apple.dock "tilesize" -int "47"
# Disable recent applications in dock
defaults write com.apple.dock "show-recents" -bool "false"
# Make dock autohide
defaults write com.apple.dock "autohide" -bool "true"
# Make dock autohide animation faster
defaults write com.apple.dock "autohide-time-modifier" -float "0.15"
# Make dock appear immediately when hovering
defaults write com.apple.dock "autohide-delay" -float "0"
# Scroll to view app in mission control (though that this was cool so I enabled it)
defaults write com.apple.dock "scroll-to-open" -bool "true"

killall Dock

dockutil --remove all
dockutil --add "/Applications/Dia.app"
dockutil --add "/Applications/Messages.app"
dockutil --add "/Applications/Legcord.app"
dockutil --add "/Applications/Music.app"
dockutil --add "/Applications/Cursor.app"
dockutil --add "/Applications/Claude.app"
dockutil --add "/Applications/Ghostty.app"
dockutil --add "/Applications/cmux.app"
dockutil --add "/Applications/Slack.app"
dockutil --add "/Applications/Linear.app"
dockutil --add "/Applications/Notion Mail.app"
dockutil --add "/Applications/Notion Calendar.app"
dockutil --add "/Applications/Notion.app"
dockutil --add "~/Downloads" --view grid --display stack

# -------------------------------- SCREENSHOTS ------------------------------- #
mkdir -p ~/Pictures/Screenshots
defaults write com.apple.screencapture "location" -string "~/Pictures/Screenshots"

killall SystemUIServer
