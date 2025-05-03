#!/usr/bin/env zsh

# MARK: STARTUP

# this is duplicated in .zshenv, since .zshenv won't load in subshells from
# other shells that override the ZDOTDIR variable
source "$HOME/.config/shell/environment"
source "$HOME/.config/shell/aliases"

tmux-autostart

mkdir -p "$XDG_STATE_HOME"/zsh/sessions

# bash also uses this env var that's why we override it here for zsh
export HISTFILE="$XDG_STATE_HOME"/zsh/history

# pokemon shell colorscripts
# --info flag prints the pokemon's pokedex entry
if command -v krabby &>/dev/null; then
  krabby random --info
fi

# MARK: KEYBINDINGS

# Use emacs mode becasue vi mode does not work with iterm2 natural text editing keybindings
# Also because I have EDITOR defined as nvim, zsh auto uses vi mode, so this overrides that
bindkey -e

# launch krabby with ctrl + k
# only bind if krabby is installed
if command -v krabby &>/dev/null; then
  bindkey -s "^k" "krabby random^M"
fi

# auto run ls (alias for eza) after cd
# builtin uses the default cd to avoid conflicts with function name
function cd { builtin cd "$@" && ls; }

# MARK: SOURCE BINARIES

# load zinit before compinit
source /opt/homebrew/opt/zinit/zinit.zsh

# MARK: COMPLETIONS

# homebrew completions must be before compinit
if command -v brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

# Enable zsh autocompletions
autoload -Uz compinit

# start and set completion dump path
compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"

# set autocompletion cache path
zstyle ":completion:*" cache-path "$XDG_CACHE_HOME"/zsh/zcompcache

# case insensitive completion
zstyle ":completion:*" matcher-list "m:{a-z}={A-Za-z}"

# MARK: PLUGINS

zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting

# MARK: PROGRAMS

eval "$(fzf --zsh)"
eval "$(zoxide init zsh --cmd cd)"
eval "$(atuin init zsh --disable-up-arrow)"
eval "$(starship init zsh)"
