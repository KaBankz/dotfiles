#!/usr/bin/env bash

# Allow the user to override the default dotfiles directory
DOTFILES_DIR="${DOTFILES_DIR:-"$HOME/.dotfiles"}"

DOTFILES_REPO="https://github.com/KaBankz/dotfiles"
DOTFILES_DOWNLOAD_URL="$DOTFILES_REPO/archive/dotter.tar.gz"
DOTTER_REPO="https://github.com/SuperCuber/dotter"
DOTTER_DOWNLOAD_URL="$DOTTER_REPO/releases/latest/download"
DOTTER_BIN="$DOTFILES_DIR/dotter"

REQUIRED_UTILS=("curl")

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
echo " ============================================ "
echo ""

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

echo "Checking prerequisites..."
for util in "${REQUIRED_UTILS[@]}"; do
  command -v "$util" >/dev/null 2>&1 || error_exit $LINENO "$util is not installed. Please install it and try again."
done

echo "Checking for existing dotfiles..."
[ -d "$DOTFILES_DIR" ] && error_exit $LINENO "$DOTFILES_DIR already exists. Please remove it or set DOTFILES_DIR to a different location."

# Create a temporary directory for downloading dotfiles
temp_dir=$(mktemp -d) || error_exit $LINENO "Failed to create temporary directory"
temp_tar="$temp_dir/dotfiles.tar.gz"

echo "Downloading dotfiles..."
curl -fsSL "$DOTFILES_DOWNLOAD_URL" --output "$temp_tar" || error_exit $LINENO "Failed to download dotfiles repository"
mkdir -p "$DOTFILES_DIR" || error_exit $LINENO "Failed to create dotfiles directory"
tar -xz -C "$DOTFILES_DIR" --strip-components=1 -f "$temp_tar" || error_exit $LINENO "Failed to extract dotfiles archive"
rm "$temp_tar"

cd "$DOTFILES_DIR" || error_exit $LINENO "Failed to change directory to $DOTFILES_DIR"

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
