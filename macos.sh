#!/usr/bin/env bash

# MacOS settings
# ref: https://mths.be/macos

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Enable linux like window dragging (drag windows from anywhere, not just titlebar)
# with CTRL+CMD+Drag
defaults write -g NSWindowShouldDragOnGesture -bool true

# Show all hidden files by default in Finder
defaults write com.apple.finder AppleShowAllFiles -bool true
