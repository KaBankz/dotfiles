# XDG Base Directory Specification
set -gx XDG_CONFIG_HOME "$HOME"/.config
set -gx XDG_CACHE_HOME "$HOME"/.cache
set -gx XDG_DATA_HOME "$HOME"/.local/share
set -gx XDG_STATE_HOME "$HOME"/.local/state

# set default editors
set -gx EDITOR nvim
set -gx VISUAL code

# set ZDOTDIR for zsh subshells
set -gx ZDOTDIR "$HOME"/.config/zsh

# set bat as the manpager if it exists
if type -q bat
    set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
end

# disable less history file
set -gx LESSHISTFILE -

# disable homebrew analytics
set -gx HOMEBREW_NO_ANALYTICS 1

# gnupg
set -gx GNUPGHOME "$XDG_DATA_HOME"/gnupg
# load gpg keys
set -gx GPG_TTY (tty)

# flutter
set -gx FLUTTER_ROOT (rtx where flutter)

# disable bun analytics
set -gx DISABLE_BUN_ANALYTICS 1

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

# # ranger
# # disable loading default ranger config, instead load local ranger config
# set -gx RANGER_LOAD_DEFAULT_RC false

# docker
set -gx DOCKER_CONFIG "$XDG_CONFIG_HOME"/docker

# path
# to avoid duplicates in PATH, we add items to a list and then add the list to PATH if it's not already there
# priority is given in accending order of the list
set ADD_TO_PATH $XDG_DATA_HOME/yarn/bin $PNPM_HOME $CARGO_HOME/bin $HOME/.local/bin

for item in $ADD_TO_PATH
    if not contains $item $PATH
        # prepend to PATH
        set -p PATH $item
    end
end
