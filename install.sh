#!/usr/bin/env bash

# Make sure the script is not being executed with superuser privileges
if [ ! "$(id -u)" -ne 0 ]; then
  echo "❌ Please do not run as root"
  exit
fi

# Current host os
os=$(uname)

# XDG dirs
XDG_CONFIG_HOME="$HOME"/.config
XDG_CACHE_HOME="$HOME"/.cache
XDG_DATA_HOME="$HOME"/.local/share
XDG_STATE_HOME="$HOME"/.local/state

# Run os specific preconfiguration
preConfig() {
  echo "⏳ Pre-configuring..."

  echo "⏳ Creating XDG dirs..."
  mkdir -p "$XDG_CONFIG_HOME" "$XDG_CACHE_HOME" "$XDG_DATA_HOME" "$XDG_STATE_HOME"

  # Make zsh history dir
  # This folder is required for zsh to store history
  mkdir -p "$XDG_STATE_HOME"/zsh
  echo "✅ Finished creating XDG dirs"

  case "$os" in
  "Darwin")
    {
      echo "🍎 Identified MacOS"

      if ! [ -x "$(command -v brew)" ]; then
        echo "🙅‍♂️ Homebrew is not installed"

        echo "⏳ Installing homebrew..."
        # Homebrew will check for xcode developer tools and install them if they are not installed
        NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        echo "✅ Installed homebrew"
      else
        echo "✅ Homebrew is already installed"
      fi
    }
    ;;
  "Linux")
    {
      echo "Identified Linux"
    }
    ;;
  *)
    {
      echo "STFU"
    }
    ;;
  esac
  echo "✅ Pre-configuration complete"
}

updateRepos() {
  echo "⏳ Updating repositories..."
  if [ -x "$(command -v pacman)" ]; then
    sudo pacman -Syu
  elif [ -x "$(command -v apt-get)" ]; then
    sudo apt-get update && sudo apt-get upgrade -y
  elif [ -x "$(command -v brew)" ]; then
    brew update && brew upgrade
  else
    echo "❌ No supported package manager found lmao"
    exit
  fi
  echo "✅ Finished updating repositories"
}

# Install packages with os specific package manager
installPackage() {
  if [ -x "$(command -v pacman)" ]; then
    sudo pacman -S "$0"
  elif [ -x "$(command -v apt-get)" ]; then
    sudo apt-get install "$0"
  elif [ -x "$(command -v brew)" ]; then
    brew install "$0"
  else
    echo "❌ No supported package manager found"
    exit
  fi
}

# Install prerequisite packages needed for the script to function
installPrerequisitePackages() {
  echo "⏳ Installing prerequisite packages..."
  prerequisites=(git stow fish)
  for package in "${prerequisites[@]}"; do
    if ! [ -x "$(command -v "$package")" ]; then
      echo "⏳ Installing $package..."
      installPackage "$package"
    else
      echo "✅ $package is already installed"
    fi
  done
  echo "✅ Finished installing prerequisite packages"
}

# Install all packages defined in dotfiles
installPackageList() {
  echo "⏳ Installing packages..."
  case "$os" in
  "Darwin")
    {
      echo "🍎 Identified MacOS"
      brew bundle --file "$HOME"/.dotfiles/pkgs/Brewfile

      ## OUTDATED METHOD
      # ? Not sure if this method works for all package managers
      # xargs installPackage < "$HOME"/.dotfiles/pkgs/brew.txt
    }
    ;;
  "Linux")
    {
      echo "Installing ** packages"
    }
    ;;
  *)
    {
      echo "STFU"
    }
    ;;
  esac
  echo "✅ Installation complete"
}

# Clone dotfiles repo
cloneDotfiles() {
  if [ -d "$HOME/.dotfiles" ]; then
    if [ "$(pwd)" == "$HOME"/.dotfiles ]; then
      echo "✅ Dotfiles repo already exists"
    else
      echo "❌ ~/.dotfiles dir already exists"
      echo "⏳ Backuping ~/.dotfiles dir..."
      mv "$HOME"/.dotfiles "$HOME"/.dotfiles.bak
      git clone "https://github.com/KaBankz/dotfiles.git" "$HOME"/.dotfiles
    fi
  else
    echo "🙅‍♂️ Dotfiles repo not cloned"

    echo "⏳ Cloning dotfiles repo..."
    git clone "https://github.com/KaBankz/dotfiles.git" "$HOME"/.dotfiles
    echo "✅ Cloned dotfiles repo"
  fi
}

# Stow all dotfiles
installDotfiles() {
  echo "⏳ Stowing dotfiles..."
  stow -Sv -d "$HOME"/.dotfiles/home -t "$HOME"
  echo "✅ Stowed dotfiles"
}

# Set system configs on MacOS
setDefaults() {
  echo "⏳ Setting defaults..."
  # Enable linux like window dragging (drag windows from anywhere, not just titlebar) with CTRL+CMD+Drag
  defaults write -g NSWindowShouldDragOnGesture -bool true
  # Show all hidden files by default in Finder
  defaults write com.apple.finder AppleShowAllFiles -bool true
  echo "✅ Finished setting defaults"
}

# Post install
postInstall() {
  echo "⏳ Post-installation..."
  if [ ! "$SHELL" == "/opt/homebrew/bin/fish" ] || [ ! "$SHELL" == "/usr/bin/fish" ]; then
    echo "🙅‍♂️ Default shell is $SHELL instead of fish"
    echo "⏳ Changing default shell to fish..."

    if [ -f "/opt/homebrew/bin/fish" ]; then
      sudo chsh -s /opt/homebrew/bin/fish
    elif [ -f "/usr/bin/fish" ]; then
      sudo chsh -s /usr/bin/fish
    else
      echo "❌ Fish not found"
    fi

    echo "✅ Changed default shell to fish"
  fi
  if [ "$os" == "Darwin" ]; then
    setDefaults
  fi
  echo "✅ Post-installation finished"
}

echo "⚡️ Starting setup script"
preConfig
updateRepos
installPrerequisitePackages
cloneDotfiles
installDotfiles
installPackageList
postInstall
echo "✅ Setup script finished"
