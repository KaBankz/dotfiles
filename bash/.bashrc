#!/usr/bin/env bash

# MARK: STARTUP

source "$HOME/.config/shell/environment"
source "$HOME/.config/shell/aliases"

tmux-autostart

mkdir -p "$XDG_STATE_HOME"/bash

# pokemon shell colorscripts
# --info flag prints the pokemon's pokedex entry
if command -v krabby &>/dev/null; then
  krabby random --info
fi

# MARK: KEYBINDINGS

# Use emacs mode
set -o emacs

# launch krabby with ctrl + k
# only bind if krabby is installed
if command -v krabby &>/dev/null; then
  bind '"\C-k":"krabby random\n"'
fi

# MARK: PROGRAMS

eval "$(fzf --bash)"
eval "$(zoxide init bash --cmd cd)"
eval "$(atuin init bash --disable-up-arrow)"
eval "$(starship init bash --print-full-init)"
