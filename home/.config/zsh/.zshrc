#!/bin/zsh

### STARTUP ###

# these are used by Apple in /etc/zshrc
# the $XDG_STATE_HOME/zsh dir has to exist for this to work so we create it if it doesn't exist
if [ ! -d "$XDG_STATE_HOME"/zsh ]; then
  mkdir -p "$XDG_STATE_HOME"/zsh
fi
# set zsh session dir
export SHELL_SESSION_DIR="$XDG_STATE_HOME"/zsh/sessions
export SHELL_SESSION_FILE="$SHELL_SESSION_DIR"/"$TERM_SESSION_ID"
# set zsh history file dir
export HISTFILE="$XDG_STATE_HOME"/zsh/history

# load homebrew
# this is up at the top to make sure it's loaded before anything else
# as homebrew manages the majority of the used binaries
# this also only runs if not in a nested shell to avoid duplicated PATH
[ "$SHLVL" -eq 1 ] && eval "$(/opt/homebrew/bin/brew shellenv)"

# start fish shell
# exec fish

# load environment variables if not in a nested shell to avoid duplicated PATH
[ -f "$XDG_CONFIG_HOME"/shell/environment ] && [ "$SHLVL" -eq 1 ] && source "$XDG_CONFIG_HOME"/shell/environment

# load aliases
# [ -f $ZDOTDIR/aliases.zsh ] && source $ZDOTDIR/aliases.zsh
[ -f "$XDG_CONFIG_HOME"/shell/aliases ] && source "$XDG_CONFIG_HOME"/shell/aliases

# clear the screen on startup to remove macos's "last login" message
clear

# pokemon shell colorscripts
krabby random

### END OF STARTUP ###

### KEYBINDINGS ###

# Use emacs mode becasue vi mode does not work with iterm2 natural text editing keybindings
# Also because I have EDITOR defined as nvim, zsh auto uses vi mode, so this overrides that
bindkey -e

# launch tmux with ctrl + t
bindkey -s "^t" "tmux^M"

# launch ranger with ctrl + r
bindkey -s "^r" "ranger^M"

# launch lazygit with ctrl + g
bindkey -s "^g" "lazygit^M"

### END OF KEYBINDINGS ###

### FUNCTIONS ###

# auto run ls (alias for exa) after cd
# builtin uses the default cd to avoid conflicts with function name
function cd { builtin cd "$@" && ls; }

# auto cd after mkdir
function mkcd {
  last=$(eval "echo \$$#")
  if [ -z "$last" ]; then
    echo "Enter a directory name"
  elif [ -d "$last" ]; then
    echo "$last already exists"
  else
    mkdir "$@" && cd "$last" || return
  fi
}

### END OF FUNCTIONS ###

### SOURCE BINARIES ###

# load zinit before compinit
source /opt/homebrew/opt/zinit/zinit.zsh

# load asdf
source /opt/homebrew/opt/asdf/libexec/asdf.sh

### END OF SOURCE BINARIES ###

### COMPLETIONS ###

# homebrew completions
# must be before compinit
if type brew &>/dev/null; then
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

### END OF COMPLETIONS ###

### PLUGINS ###

zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting

### END OF PLUGINS ###

### START STARSHIP PROMPT ###
eval "$(starship init zsh)"
