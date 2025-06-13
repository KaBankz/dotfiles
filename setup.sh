#!/usr/bin/env bash

# KaBankz' Dotfiles Bootstrapper

set -euo pipefail # Exit on error, undefined vars, pipe failures
IFS=$'\n\t'       # Secure Internal Field Separator

# ================================ CONFIGURATION ================================ #

readonly DOTFILES_DIR="${DOTFILES_DIR:-"$HOME/.dotfiles"}"
readonly DOTFILES_REPO="https://github.com/KaBankz/dotfiles.git"
readonly DOTFILES_BRANCH="dotter"
readonly DOTTER_REPO="https://github.com/SuperCuber/dotter"
readonly DOTTER_DOWNLOAD_URL="$DOTTER_REPO/releases/latest/download"
readonly DOTTER_BIN="$DOTFILES_DIR/dotter"

readonly -a REQUIRED_UTILS=("curl" "git")

# ================================== LOGGING =================================== #

# Color codes for output
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m' # No Color

log_info() {
  printf "${BLUE}[INFO]${NC} %s\n" "$*" >&2
}

log_success() {
  printf "${GREEN}[SUCCESS]${NC} %s\n" "$*" >&2
}

log_warning() {
  printf "${YELLOW}[WARNING]${NC} %s\n" "$*" >&2
}

log_error() {
  printf "${RED}[ERROR]${NC} %s\n" "$*" >&2
}

# ================================ ERROR HANDLING =============================== #

cleanup() {
  local exit_code=$?
  if [[ $exit_code -ne 0 ]]; then
    log_error "Script failed with exit code $exit_code"
    log_error "Check the output above for details"
  fi
  exit $exit_code
}

trap cleanup EXIT

# ================================== UTILITIES ================================== #

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

is_macos() {
  [[ "$(uname -s)" == "Darwin" ]]
}

get_os_arch() {
  local os arch
  os="$(uname -s | tr '[:upper:]' '[:lower:]')"
  arch="$(uname -m)"

  case "$arch" in
  x86_64) arch="x64" ;;
  aarch64) arch="arm64" ;;
  esac

  printf "%s-%s" "$os" "$arch"
}

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

  printf "%s" "$url"
}

# ================================= MAIN FUNCTIONS ============================== #

show_banner() {
  cat <<'EOF'
 ============================================
        __ _       _    __ _ _
       / /| |     | |  / _(_) |
      / /_| | ___ | |_| |_ _| | ___  ___
     / / _` |/ _ \| __|  _| | |/ _ \/ __|
  _ / / (_| | (_) | |_| | | | |  __/\__ \
 (_)_/ \__,_|\___/ \__|_| |_|_|\___||___/

 https://github.com/KaBankz/dotfiles

 KaBankz' Dotfiles Bootstrapper

 KABANKZ IS NOT RESPONSIBLE FOR ANY DAMAGE
 CAUSED BY THIS SCRIPT. USE AT YOUR OWN RISK.

 Configuration:
 Set DOTFILES_DIR to use a custom directory

EOF
  printf " DOTFILES_DIR=%s\n" "$DOTFILES_DIR"
  cat <<'EOF'

 ============================================

EOF
}

# Generic function for asking user consent with Y/n pattern
ask_user_consent() {
  local prompt="$1"
  local choice
  read -rp "$prompt (Y/n): " choice
  case "$choice" in
  [Nn] | [Nn][Oo])
    return 1 # User said no
    ;;
  *)
    return 0 # User said yes (default)
    ;;
  esac
}

get_user_consent() {
  if ask_user_consent "Do you agree and wish to continue?"; then
    return 0
  else
    log_info "Setup cancelled by user"
    exit 0
  fi
}

install_homebrew() {
  if ! is_macos; then
    return 0
  fi

  log_info "Checking for Homebrew..."

  if command_exists brew; then
    log_success "Homebrew is already installed"
    return 0
  fi

  log_info "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Add Homebrew to PATH for the current session (Apple Silicon Mac)
  if [[ -f "/opt/homebrew/bin/brew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi

  log_success "Homebrew installed successfully"
}

check_prerequisites() {
  log_info "Checking prerequisites..."

  local missing_utils=()
  for util in "${REQUIRED_UTILS[@]}"; do
    if ! command_exists "$util"; then
      missing_utils+=("$util")
    fi
  done

  if [[ ${#missing_utils[@]} -gt 0 ]]; then
    log_error "Missing required utilities: ${missing_utils[*]}"
    log_error "Please install them and try again"
    return 1
  fi

  log_success "All prerequisites satisfied"
}

clone_or_update_dotfiles() {
  if [[ -d "$DOTFILES_DIR" ]]; then
    update_existing_dotfiles
  else
    clone_fresh_dotfiles
  fi
}

update_existing_dotfiles() {
  log_info "Dotfiles directory exists. Validating..."

  if [[ ! -d "$DOTFILES_DIR/.git" ]]; then
    log_error "$DOTFILES_DIR exists but is not a git repository"
    log_error "Please remove it or set DOTFILES_DIR to a different location"
    return 1
  fi

  cd "$DOTFILES_DIR"

  # Validate remote repository
  local current_remote normalized_current normalized_expected
  current_remote="$(git remote get-url origin 2>/dev/null)"
  normalized_current="$(normalize_git_url "$current_remote")"
  normalized_expected="$(normalize_git_url "$DOTFILES_REPO")"

  if [[ "$normalized_current" != "$normalized_expected" ]]; then
    log_error "Repository remote mismatch:"
    log_error "  Current:  $current_remote"
    log_error "  Expected: $DOTFILES_REPO"
    log_error "Please remove the directory or set DOTFILES_DIR to a different location"
    return 1
  fi

  log_info "Valid repository found. Updating..."

  # Update repository
  git fetch origin

  local current_branch
  current_branch="$(git branch --show-current)"
  if [[ "$current_branch" != "$DOTFILES_BRANCH" ]]; then
    log_info "Switching to branch '$DOTFILES_BRANCH'..."
    git checkout "$DOTFILES_BRANCH"
  fi

  git pull origin "$DOTFILES_BRANCH"
  log_success "Dotfiles updated successfully"
}

clone_fresh_dotfiles() {
  log_info "Cloning dotfiles repository..."
  git clone --branch "$DOTFILES_BRANCH" "$DOTFILES_REPO" "$DOTFILES_DIR"
  cd "$DOTFILES_DIR"
  log_success "Dotfiles cloned successfully"
}

download_dotter() {
  log_info "Downloading Dotter..."

  local os_arch dotter_url
  os_arch="$(get_os_arch)"

  case "$os_arch" in
  linux-x64)
    dotter_url="$DOTTER_DOWNLOAD_URL/dotter-linux-x64-musl"
    cp ".dotter/server.toml" ".dotter/local.toml"
    ;;
  linux-arm64)
    dotter_url="$DOTTER_DOWNLOAD_URL/dotter-linux-arm64-musl"
    cp ".dotter/server.toml" ".dotter/local.toml"
    ;;
  darwin-arm64)
    dotter_url="$DOTTER_DOWNLOAD_URL/dotter-macos-arm64.arm"
    cp ".dotter/macos.toml" ".dotter/local.toml"
    ;;
  *)
    log_error "Unsupported platform: $os_arch"
    return 1
    ;;
  esac

  curl -fsSL "$dotter_url" -o "$DOTTER_BIN"
  chmod +x "$DOTTER_BIN"

  log_success "Dotter downloaded successfully"
}

deploy_dotfiles() {
  log_info "Deploying dotfiles..."
  "$DOTTER_BIN" deploy -v
  log_success "Dotfiles deployed successfully"
}

configure_macos() {
  if ! is_macos; then
    return 0
  fi

  if [[ -f "macos.sh" ]]; then
    log_info "Running macOS configuration..."
    bash macos.sh
    log_success "macOS configuration completed"
  else
    log_warning "macos.sh not found, skipping macOS configuration"
  fi
}

install_packages() {
  if ! is_macos; then
    return 0
  fi

  if [[ -f "pkgs/Brewfile" ]]; then
    log_info "Installing packages from Brewfile..."
    brew bundle install --file="pkgs/Brewfile"
    log_success "Package installation completed"
  else
    log_warning "pkgs/Brewfile not found, skipping package installation"
  fi
}

configure_gpg() {
  log_info "Configuring GPG..."

  mkdir -p "$HOME/.local/share/gnupg"
  chmod 700 "$HOME/.local/share/gnupg"

  # Initialize GPG keyring (creates default keyring on new devices)
  gpg --list-keys >/dev/null 2>&1

  log_success "GPG configured successfully"
}

configure_touchid_sudo() {
  if ! is_macos; then
    return 0
  fi

  log_info "Configuring TouchID for sudo..."

  local template_file="/etc/pam.d/sudo_local.template"
  local target_file="/etc/pam.d/sudo_local"

  # Check if template file exists
  if [[ ! -f "$template_file" ]]; then
    log_warning "Local sudo config template not found at $template_file, skipping TouchID configuration"
    return 0
  fi

  # Check if TouchID is already configured
  local pam_reattach_path="/opt/homebrew/lib/pam/pam_reattach.so"
  local touchid_configured=false
  local pam_reattach_configured=false

  if [[ -f "$target_file" ]]; then
    if grep -q "^auth.*pam_tid.so" "$target_file" 2>/dev/null; then
      touchid_configured=true
    fi
    if grep -q "^auth.*pam_reattach.so" "$target_file" 2>/dev/null; then
      pam_reattach_configured=true
    fi
  fi

  # Check if configuration is complete
  local needs_pam_reattach=false
  if [[ -f "$pam_reattach_path" ]]; then
    needs_pam_reattach=true
  fi

  # If TouchID is configured and pam_reattach is either not needed or already configured, we're done
  if [[ "$touchid_configured" == true ]] && [[ "$needs_pam_reattach" == false || "$pam_reattach_configured" == true ]]; then
    log_success "TouchID for sudo is already configured"
    if [[ "$pam_reattach_configured" == true ]]; then
      log_success "TouchID in tmux is also already configured"
    fi
    return 0
  fi

  # Configure TouchID and optionally pam_reattach for tmux support
  local temp_file
  temp_file=$(mktemp)

  # Start with the template
  sed -e 's/^#auth/auth/' "$template_file" >"$temp_file"

  # If pam_reattach is available, add it above the TouchID line for tmux support
  if [[ -f "$pam_reattach_path" ]]; then
    log_info "Adding pam_reattach for TouchID support in tmux..."
    # Insert pam_reattach line before the pam_tid.so line
    sed -i '' '/auth.*sufficient.*pam_tid\.so/i\
auth       optional       /opt/homebrew/lib/pam/pam_reattach.so
' "$temp_file"
  fi

  # Deploy the configuration
  if sudo cp "$temp_file" "$target_file"; then
    log_success "TouchID for sudo configured successfully"
    if [[ -f "$pam_reattach_path" ]]; then
      log_success "TouchID in tmux is also supported via pam_reattach"
    fi
  else
    log_error "Failed to configure TouchID for sudo"
    rm -f "$temp_file"
    return 1
  fi

  rm -f "$temp_file"
}

set_default_shell() {
  log_info "Setting fish as the default shell..."

  local fish_path
  if is_macos; then
    fish_path="/opt/homebrew/bin/fish"
  else
    fish_path="/usr/bin/fish"
  fi

  # Check if fish is installed
  if [[ ! -x "$fish_path" ]]; then
    log_warning "Fish shell not found at $fish_path, skipping shell configuration"
    return 0
  fi

  # Check if fish is already in /etc/shells
  if ! grep -q "^$fish_path$" /etc/shells 2>/dev/null; then
    log_info "Adding fish to /etc/shells..."
    echo "$fish_path" | sudo tee -a /etc/shells >/dev/null
  fi

  # Check if fish is already the default shell
  if [[ "$SHELL" == "$fish_path" ]]; then
    log_success "Fish is already the default shell"
    return 0
  fi

  # Set fish as the default shell
  log_info "Changing default shell to fish..."
  chsh -s "$fish_path"

  log_success "Default shell set to fish"
  log_info "You'll need to restart your terminal or log out and back in for the change to take effect"
}

mise_install() {
  if ! command_exists mise; then
    log_warning "mise is not installed, skipping tool installation"
    return 0
  fi

  if ask_user_consent "Do you want to install mise tools now?"; then
    log_info "Installing mise tools..."
    mise install --cd "$HOME"
    log_success "mise tools installed successfully"
  else
    log_info "Skipping mise tool installation"
  fi
}

check_system_updates() {
  if ! is_macos; then
    return 0
  fi

  # Custom consent function for system updates (defaults to No)
  local choice
  read -rp "Do you want to check for and install macOS system updates? (y/N): " choice
  case "$choice" in
  [Yy] | [Yy][Ee][Ss])
    # User said yes, proceed
    ;;
  *)
    log_info "Skipping system updates"
    return 0
    ;;
  esac

  log_info "Checking for macOS system updates..."

  # Check for available updates
  local updates_available
  if updates_available=$(softwareupdate -l 2>&1); then
    if echo "$updates_available" | grep -q "No new software available"; then
      log_success "Your system is up to date!"
      return 0
    fi

    log_info "Available updates found:"
    echo "$updates_available"

    log_info "Installing system updates... This may take a while and require a restart."
    log_warning "DO NOT interrupt this process!"

    # Install all recommended updates with automatic restart and license agreement
    sudo softwareupdate -iaR --agree-to-license

    log_success "System updates installed successfully!"
    log_info "Your system will restart automatically if required"
  else
    log_error "Failed to check for system updates"
    log_error "You may need to check manually via System Preferences"
    return 1
  fi
}

# ================================== MAIN SCRIPT ================================ #

main() {
  show_banner
  get_user_consent

  install_homebrew
  check_prerequisites
  clone_or_update_dotfiles
  download_dotter
  deploy_dotfiles
  configure_macos
  install_packages
  configure_gpg
  configure_touchid_sudo
  set_default_shell
  mise_install
  check_system_updates

  log_success "Dotfiles setup completed successfully!"
  log_info "You may need to restart your terminal or source your shell configuration"
}

main "$@"
