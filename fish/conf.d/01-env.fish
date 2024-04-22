# XDG Base Directory Specification
set -gx XDG_CONFIG_HOME "$HOME"/.config
set -gx XDG_CACHE_HOME "$HOME"/.cache
set -gx XDG_DATA_HOME "$HOME"/.local/share
set -gx XDG_STATE_HOME "$HOME"/.local/state

# set default editors
set -gx EDITOR nvim
set -gx VISUAL code --wait

# set ZDOTDIR for zsh subshells
set -gx ZDOTDIR "$HOME"/.config/zsh

# set bat as the manpager if it exists
if type -q bat
    set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
end

# disable less history file
set -gx LESSHISTFILE -

# disable homebrew analytics
set -gx HOMEBREW_NO_ANALYTICS 1

# disable mise command not found (b/c it overrides my brew command not found)
set -gx MISE_NOT_FOUND_AUTO_INSTALL false

# gnupg
set -gx GNUPGHOME "$XDG_DATA_HOME"/gnupg
# load gpg keys
set -gx GPG_TTY (tty)

# flutter
set -gx FLUTTER_ROOT (runx mise where flutter)

# gradle
set -gx GRADLE_USER_HOME "$XDG_DATA_HOME"/gradle

# disable bun analytics
set -gx DISABLE_BUN_ANALYTICS 1
# set bun install path
set -gx BUN_INSTALL "$XDG_DATA_HOME/bun"

# node corepack
set -gx COREPACK_HOME "$XDG_DATA_HOME"/node/corepack

# npm
set -gx NPM_CONFIG_USERCONFIG "$XDG_CONFIG_HOME"/npm/npmrc
set -gx NODE_REPL_HISTORY "$XDG_DATA_HOME"/node_repl_history

# pnpm
set -gx PNPM_HOME "$XDG_DATA_HOME"/pnpm

# rust
set -gx RUSTUP_HOME "$XDG_DATA_HOME"/rustup
set -gx CARGO_HOME "$XDG_DATA_HOME"/cargo

# cocoapods
set -gx CP_HOME_DIR "$XDG_DATA_HOME"/cocoapods

# docker
set -gx DOCKER_CONFIG "$XDG_CONFIG_HOME"/docker

# path
fish_add_path -P "$XDG_DATA_HOME"/yarn/bin
fish_add_path -P "$PNPM_HOME"
fish_add_path -P "$BUN_INSTALL"/bin
fish_add_path -P "$CARGO_HOME"/bin
fish_add_path -P "$HOME"/.local/bin
