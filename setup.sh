#!/usr/bin/env bash

# Allow the user to override the default dotfiles directory
DOTFILES_DIR="${DOTFILES_DIR:-"$HOME/.dotfiles"}"

DOTFILES_REPO="https://github.com/KaBankz/dotfiles.git"
DOTFILES_BRANCH="dotter"
DOTTER_REPO="https://github.com/SuperCuber/dotter"
DOTTER_DOWNLOAD_URL="$DOTTER_REPO/releases/latest/download"
DOTTER_BIN="$DOTFILES_DIR/dotter"

REQUIRED_UTILS=("curl" "git")

echo " ============================================ "
echo "        __ _       _    __ _ _                "
echo "       / /| |     | |  / _(_) |               "
echo "      / /_| | ___ | |_| |_ _| | ___  ___      "
echo "     / / _\` |/ _ \| __|  _| | |/ _ \/ __|    "
echo "  _ / / (_| | (_) | |_| | | | |  __/\__ \     "
echo " (_)_/ \__,_|\___/ \__|_| |_|_|\___||___/     "
echo "                                              "
echo " https://github.com/KaBankz/dotfiles          "
echo "                                              "
echo " KaBankz' Dotfiles bootstrapper               "
echo "                                              "
echo " KABANKZ IS NOT RESPONSIBLE FOR ANY DAMAGE    "
echo " CAUSED BY THIS SCRIPT. USE AT YOUR OWN RISK. "
echo "                                              "
echo " Audit the script at:                         "
echo " https://github.com/KaBankz/dotfiles/blob/dotter/setup.sh "
echo "                                              "
echo " Configuration:                               "
echo " Set DOTFILES_DIR to use a custom directory   "
echo "                                              "
echo " DOTFILES_DIR=$DOTFILES_DIR                   "
echo "                                              "
echo " Only run this script once, running it again  "
echo " will cause errors.                           "
echo " ============================================ "
echo "                                              "

# TODO:
# - Break down the script into functions
# - Add ability to update the dotfiles (needs git)
# - Check for dotter before downloading it
# - Check for local.toml before copying it

read -rp "Do you agree and wish to continue? (y/N): " choice
case "$choice" in
y | Y) ;;
*)
  exit 0
  ;;
esac

error_exit() {
  local line_number=$1
  local error_message=$2
  local exit_code=${3:-1}
  echo "[Line $line_number] Error: $error_message" >&2
  exit "$exit_code"
}

clone_or_update_dotfiles() {
  if [ -d "$DOTFILES_DIR" ]; then
    echo "Dotfiles directory exists. Checking if it's a valid git repository..."

    if [ ! -d "$DOTFILES_DIR/.git" ]; then
      error_exit $LINENO "$DOTFILES_DIR exists but is not a git repository. Please remove it or set DOTFILES_DIR to a different location."
    fi

    cd "$DOTFILES_DIR" || error_exit $LINENO "Failed to change directory to $DOTFILES_DIR"

    # Check if the remote origin matches our expected repository
    local current_remote
    current_remote=$(git remote get-url origin 2>/dev/null) || error_exit $LINENO "Failed to get remote origin URL"

    # Normalize URLs for comparison (handle both HTTPS and SSH formats)
    normalize_git_url() {
      local url="$1"
      # Remove .git suffix
      url="${url%.git}"
      # Convert SSH format to HTTPS-like format for comparison
      if [[ "$url" =~ ^git@github\.com: ]]; then
        url="${url#git@github.com:}"
        url="github.com/$url"
      elif [[ "$url" =~ ^https://github\.com/ ]]; then
        url="${url#https://}"
      fi
      echo "$url"
    }

    local normalized_current
    local normalized_expected
    normalized_current=$(normalize_git_url "$current_remote")
    normalized_expected=$(normalize_git_url "$DOTFILES_REPO")

    if [ "$normalized_current" != "$normalized_expected" ]; then
      error_exit $LINENO "Existing repository points to '$current_remote' but expected '$DOTFILES_REPO'. Please remove the directory or set DOTFILES_DIR to a different location."
    fi

    echo "Valid dotfiles repository found. Pulling latest changes..."

    # Fetch latest changes and checkout the correct branch
    git fetch origin || error_exit $LINENO "Failed to fetch latest changes"

    # Check if we're on the correct branch, if not switch to it
    local current_branch
    current_branch=$(git branch --show-current)
    if [ "$current_branch" != "$DOTFILES_BRANCH" ]; then
      echo "Switching to branch '$DOTFILES_BRANCH'..."
      git checkout "$DOTFILES_BRANCH" || error_exit $LINENO "Failed to checkout branch '$DOTFILES_BRANCH'"
    fi

    # Pull latest changes
    git pull origin "$DOTFILES_BRANCH" || error_exit $LINENO "Failed to pull latest changes"

    echo "Dotfiles updated successfully."
  else
    echo "Cloning dotfiles repository..."
    git clone --branch "$DOTFILES_BRANCH" "$DOTFILES_REPO" "$DOTFILES_DIR" || error_exit $LINENO "Failed to clone dotfiles repository"

    cd "$DOTFILES_DIR" || error_exit $LINENO "Failed to change directory to $DOTFILES_DIR"

    echo "Dotfiles cloned successfully."
  fi
}

# Check if we're on macOS and install Homebrew if needed
if [[ "$(uname)" == "Darwin" ]]; then
  echo "Checking for Homebrew..."
  if ! command -v brew >/dev/null 2>&1; then
    echo "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || error_exit $LINENO "Failed to install Homebrew"

    # Add Homebrew to PATH for the current session
    if [[ -f "/opt/homebrew/bin/brew" ]]; then
      # Apple Silicon Mac
      eval "$(/opt/homebrew/bin/brew shellenv)"
    fi

    echo "Homebrew installed successfully."
  else
    echo "Homebrew is already installed."
  fi
fi

echo "Checking prerequisites..."
for util in "${REQUIRED_UTILS[@]}"; do
  command -v "$util" >/dev/null 2>&1 || error_exit $LINENO "$util is not installed. Please install it and try again."
done

# Clone or update dotfiles repository
clone_or_update_dotfiles

echo "Downloading Dotter..."

OS="$(uname | tr '[:upper:]' '[:lower:]')"
ARCH="$(uname -m)"

# Map the architecture to Dotter binary name
case "$OS" in
linux)
  cp ".dotter/server.toml" ".dotter/local.toml" || error_exit $LINENO "Failed to copy local.toml"

  case "$ARCH" in
  x86_64)
    DOTTER_URL="$DOTTER_DOWNLOAD_URL/dotter-linux-x64-musl"
    ;;
  arm64 | aarch64)
    DOTTER_URL="$DOTTER_DOWNLOAD_URL/dotter-linux-arm64-musl"
    ;;
  *)
    error_exit $LINENO "Unsupported architecture: $ARCH"
    ;;
  esac
  ;;
darwin)
  cp ".dotter/macos.toml" ".dotter/local.toml" || error_exit $LINENO "Failed to copy local.toml"

  case "$ARCH" in
  arm64)
    DOTTER_URL="$DOTTER_DOWNLOAD_URL/dotter-macos-arm64.arm"
    ;;
  *)
    error_exit $LINENO "Unsupported architecture: $ARCH"
    ;;
  esac
  ;;
*)
  error_exit $LINENO "Unsupported OS: $OS"
  ;;
esac

curl -fsSL "$DOTTER_URL" -o "$DOTTER_BIN" || error_exit $LINENO "Failed to download Dotter"
chmod +x "$DOTTER_BIN" || error_exit $LINENO "Failed to make Dotter executable"

echo "Deploying dotfiles..."
"$DOTTER_BIN" deploy -v || error_exit $LINENO "Dotter deploy failed"

echo "Dotfiles bootstrapped successfully."
