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

set -gx MANPATH /opt/homebrew/share/man (path_helper -m)
set -gx INFOPATH /opt/homebrew/share/info

fish_add_path -P /opt/homebrew/bin /opt/homebrew/sbin

set -gx EDITOR nvim
set -gx VISUAL code --wait

# set ZDOTDIR for zsh subshells
set -gx ZDOTDIR $XDG_CONFIG_HOME/zsh

# set bat as the manpager if it exists
if type -q bat
    set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
end

# disable less history file
set -gx LESSHISTFILE -

# set bash history file
# dir must exist else bash will not save history
set -gx HISTFILE $XDG_STATE_HOME/bash/history

set -gx ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX 1

# disable mise command not found (b/c it overrides my brew command not found)
set -gx MISE_NOT_FOUND_AUTO_INSTALL 0
# disable auto activation in favor of using shims i.e adding shims dir to path
set -gx MISE_FISH_AUTO_ACTIVATE 0

set -gx GNUPGHOME $XDG_DATA_HOME/gnupg
# load gpg keys
set -gx GPG_TTY (tty)

set -gx ANDROID_HOME $HOME/Library/Android/sdk

# set -gx FLUTTER_ROOT (runx mise where flutter)

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
fish_add_path -P $HOME/.local/bin
fish_add_path -P $XDG_DATA_HOME/mise/shims
