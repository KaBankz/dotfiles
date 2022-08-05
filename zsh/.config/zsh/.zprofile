# Load homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"
# Disable homebrew analytics
export HOMEBREW_NO_ANALYTICS=1

# gnupg
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
# Load gpg keys
export GPG_TTY=$(tty)

# These are used by Apple in /etc/zshrc, which is sourced _before_ .zshrc
# Wouldn't have to go in .zprofile otherwise.
# We could put them in .zshenv, but that file is best kept as small as possible.
#
# Warning, the $XDG_STATE_HOME/zsh dir may have to exist for this to work
# not exactly sure, more testing required
export SHELL_SESSION_DIR="$XDG_STATE_HOME/zsh/sessions"
export SHELL_SESSION_FILE="$SHELL_SESSION_DIR/$TERM_SESSION_ID"

# Disable less history file creation
export LESSHISTFILE=-

# DOOM Emacs
export PATH="$XDG_CONFIG_HOME/emacs/bin:$PATH"

# NPM
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"

# PNPM
export PNPM_HOME="/Users/zakee/.local/share/pnpm"

# NODE COREPACK
export COREPACK_HOME="$XDG_DATA_HOME/node/corepack"

# Rust
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"

# ASDF
export ASDF_CONFIG_FILE="${XDG_CONFIG_HOME}/asdf/asdfrc"
export ASDF_DATA_DIR="${XDG_DATA_HOME}/asdf"

# Ranger
# Disable loading default ranger config, instead load local ranger config
export RANGER_LOAD_DEFAULT_RC=false

# MySQL
export MYSQL_HISTFILE="$XDG_DATA_HOME/mysql_history"

# myCLI - Fancy MySQL CLI
export MYCLI_HISTFILE="$XDG_DATA_HOME/mycli-history"

# Docker
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
