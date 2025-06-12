set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_CACHE_HOME $HOME/.cache
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_STATE_HOME $HOME/.local/state

set -gx HOMEBREW_PREFIX /opt/homebrew
set -gx HOMEBREW_CELLAR /opt/homebrew/Cellar
set -gx HOMEBREW_REPOSITORY /opt/homebrew
set -gx HOMEBREW_NO_ANALYTICS 1
set -gx HOMEBREW_BAT 1
set -gx HOMEBREW_DISPLAY_INSTALL_TIMES 1

fish_add_path -P $HOMEBREW_PREFIX/bin $HOMEBREW_PREFIX/sbin

# zsh
set -gx ZDOTDIR $XDG_CONFIG_HOME/zsh
# these dirs must exist else zsh will not honor the session dir
set -gx SHELL_SESSION_DIR $XDG_STATE_HOME/zsh/sessions
set -gx SHELL_SESSION_FILE $SHELL_SESSION_DIR/$TERM_SESSION_ID

# set bash history file
# dir must exist else bash will not save history
set -gx HISTFILE $XDG_STATE_HOME/bash/history

# set 1Password ssh-agent socket
if uname -a | grep -q Darwin
    set -gx SSH_AUTH_SOCK $HOME/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
end

if type -q nvim
    set -gx EDITOR nvim
end

if type -q cursor
    set -gx VISUAL cursor --wait
end

if type -q bat
    set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
end

set -gx LESSHISTFILE -

set -gx ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX 1

set -gx MISE_NODE_COREPACK 1

set -gx GNUPGHOME $XDG_DATA_HOME/gnupg
# load gpg keys
set -gx GPG_TTY (tty)

set -gx JJ_CONFIG $XDG_CONFIG_HOME/jj/config.toml

set -gx ANDROID_HOME $HOME/Library/Android/sdk

set -gx GRADLE_USER_HOME $XDG_DATA_HOME/gradle

set -gx DISABLE_BUN_ANALYTICS 1
set -gx BUN_INSTALL $XDG_DATA_HOME/bun
set -gx BUN_INSTALL_GLOBAL_DIR $BUN_INSTALL/install/global
set -gx BUN_INSTALL_BIN $BUN_INSTALL/bin
set -gx BUN_INSTALL_CACHE_DIR $XDG_CACHE_HOME/bun

set -gx NPM_CONFIG_USERCONFIG $XDG_CONFIG_HOME/npm/npmrc
set -gx NODE_REPL_HISTORY $XDG_DATA_HOME/node_repl_history

set -gx PNPM_HOME $XDG_DATA_HOME/pnpm

set -gx RUSTUP_HOME $XDG_DATA_HOME/rustup
set -gx CARGO_HOME $XDG_DATA_HOME/cargo

set -gx CP_HOME_DIR $XDG_DATA_HOME/cocoapods

set -gx DOCKER_CONFIG $XDG_CONFIG_HOME/docker

fish_add_path -P $ANDROID_HOME/cmdline-tools/latest/bin $ANDROID_HOME/platform-tools
fish_add_path -P $XDG_DATA_HOME/yarn/bin $PNPM_HOME $BUN_INSTALL/bin
fish_add_path -P $CARGO_HOME/bin
fish_add_path -P $HOME/.orbstack/bin
fish_add_path -P $HOME/.local/bin
