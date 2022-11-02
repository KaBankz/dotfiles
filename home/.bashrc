#!/bin/bash

### STARTUP ###

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
[ -f "$XDG_CONFIG_HOME"/shell/aliases ] && source "$XDG_CONFIG_HOME"/shell/aliases

# clear the screen on startup to remove macos's "last login" message
clear

# pokemon shell colorscripts
krabby random

### END OF STARTUP ###

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

# get cheatsheets from cheat.sh
function ch {
  # $@ = all passed in queries
  queries=("$@")
  # concatnate all passed in queries into one string with "+" between each query
  # then append that to the cheat.sh url and curl it
  url="https://cheat.sh/${queries// /+}"
  echo "$url"
  curl "$url"
}

### END OF FUNCTIONS ###

### SOURCE BINARIES ###

# load asdf
source /opt/homebrew/opt/asdf/libexec/asdf.sh

### END OF SOURCE BINARIES ###

### COMPLETIONS ###

# homebrew completions
# must be before compinit
if type brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

### END OF COMPLETIONS ###

### START STARSHIP PROMPT ###
eval "$(starship init bash)"
