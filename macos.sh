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

# ------------------------------ MOUSE/TRACKPAD ------------------------------ #
# Enable linux like window dragging (drag windows from anywhere, not just titlebar)
# with CTRL+CMD+Drag
defaults write -g NSWindowShouldDragOnGesture -bool "true"
# Set mouse speed to 1.5
defaults write NSGlobalDomain com.apple.mouse.scaling -float "1.5"
# Enable 3 finger drag
defaults write com.apple.AppleMultitouchTrackpad "TrackpadThreeFingerDrag" -bool "true"

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

# -------------------------------- SCREENSHOTS ------------------------------- #
defaults write com.apple.screencapture "location" -string "~/Pictures/Screenshots"

killall SystemUIServer
