#!/bin/bash

# Make sure the script is being executed with superuser privileges
if [ ! $(id -u) -ne 0 ]; then
  echo "❌ Please run as root"
  exit
fi

# Current host os
os=$(uname)

# XDG dirs
XDG_CONFIG_HOME="$HOME/.config"
XDG_CACHE_HOME="$HOME/.cache"
XDG_DATA_HOME="$HOME/.local/share"
XDG_STATE_HOME="$HOME/.local/state"

# Create XDG dirs
createXDGDirs() {
  echo "⏳ Creating XDG dirs..."
  mkdir -p $XDG_CONFIG_HOME
  mkdir -p $XDG_CACHE_HOME
  mkdir -p $XDG_DATA_HOME
  mkdir -p $XDG_STATE_HOME

  # Make zsh history dir
  # This folder is required for zsh to store history
  mkdir -p $XDG_STATE_HOME/zsh
  echo "✅ Finished creating XDG dirs"
}

# Run os specific preconfiguration
preConfig() {
  echo "⏳ Pre-configuring..."
  case "$os" in
  "Darwin")
    {
      echo "🍎 Identified MacOS"

      if [ ! command -v xcode-select -p ] &>/dev/null; then
        echo "🙅‍♂️ xcode command line tools are not installed"

        echo "⏳ Installing xcode command line tools"
        # xcode-select --install
        echo "✅ Installed xcode command line tools"
      else
        echo "✅ xcode command line tools are already installed"
      fi

      if [ ! command -v brew ] &>/dev/null; then
        echo "🙅‍♂️ Homebrew is not installed"

        echo "⏳ Installing homebrew"
        # curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash
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

# Install packages with os specific package manager
installPackage() {
  if [ command -v pacman -p ] &>/dev/null; then
    pacman -S $0
  elif [ command -v apt -p ] &>/dev/null; then
    apt install $0
  elif [ command -v brew -p ] &>/dev/null; then
    brew install $0
  else
    echo "❌ No supported package manager found"
  fi
}

# Install prerequisite packages needed for the script to function
installPrerequisitePackages() {
  echo "⏳ Installing prerequisite packages..."
  prerequisites=(git stow zsh)
  for package in "${prerequisites[@]}"; do
    if [ ! command -v $package -p ] &>/dev/null; then
      echo "⏳ Installing $package"
      # installPackage $package
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
			# brew bundle --file $HOME/.dotfiles/pkgs/Brewfile
      
			## OUTDATED METHOD
			# ? Not sure if this method works for all package managers
      # xargs installPackage < $HOME/.dotfiles/pkgs/brew.txt
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
    echo "✅ Dotfiles repo already cloned"
  else
    echo "🙅‍♂️ Dotfiles repo not cloned"

    echo "⏳ Cloning dotfiles repo"
    # git clone "https://github.com/KaBankz/dotfiles.git" $HOME/.dotfiles
    echo "✅ Cloned dotfiles repo"
  fi
}

# Stow all dotfiles
installDotfiles() {
  echo "⏳ Stowing dotfiles"
  # stow -Sv -d $HOME/.dotfiles -t $HOME
  echo "✅ Stowed dotfiles"
}

# Set system configs on MacOS
setDefaults() {
	echo "⏳ Setting defaults"
# Enable linux like window dragging (drag windows from anywhere, not just titlebar) with CTRL+CMD+Drag
  # defaults write -g NSWindowShouldDragOnGesture -bool true
	echo "✅ Finished setting defaults"
}

# Post install
postInstall() {
  echo "⏳ Post-installation"
  echo "⏳ Changing default shell to zsh"
  # chsh -s /bin/zsh
  echo "✅ Changed default shell to zsh"
  if [ $os == "Darwin" ]; then
    echo "⏳ Setting system defaults"
    setDefaults
    echo "✅ Set system defaults"
  fi
  echo "✅ Post-installation finished"
}

echo "⚡️ Starting setup script"
createXDGDirs
preConfig
installPrerequisitePackages
cloneDotfiles
installDotfiles
installPackageList
postInstall
echo "✅ Setup script finished"
