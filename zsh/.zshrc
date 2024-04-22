#!/bin/zsh

### STARTUP ###

XDG_CONFIG_HOME="$HOME"/.config
XDG_STATE_HOME="$HOME"/.local/state

# these are used by Apple in /etc/zshrc
# the $XDG_STATE_HOME/zsh dir has to exist for this to work so we create it if it doesn't exist
if [ ! -d "$XDG_STATE_HOME"/zsh ]; then
  mkdir -p "$XDG_STATE_HOME"/zsh
fi

export SHELL_SESSION_DIR="$XDG_STATE_HOME"/zsh/sessions
export SHELL_SESSION_FILE="$SHELL_SESSION_DIR"/"$TERM_SESSION_ID"
export HISTFILE="$XDG_STATE_HOME"/zsh/history

if [ "$SHLVL" -eq 1 ]; then
  source "$XDG_CONFIG_HOME"/shell/homebrew
  source "$XDG_CONFIG_HOME"/shell/environment
  source "$XDG_CONFIG_HOME"/shell/aliases
fi

# pokemon shell colorscripts
# --info flag prints the pokemon's pokedex entry
if type krabby &>/dev/null; then
  krabby random --info
fi

### END OF STARTUP ###

### KEYBINDINGS ###

# Use emacs mode becasue vi mode does not work with iterm2 natural text editing keybindings
# Also because I have EDITOR defined as nvim, zsh auto uses vi mode, so this overrides that
bindkey -e

# launch fzf with ctrl + f
# only bind if fzf is installed
if type fzf &>/dev/null; then
  bindkey -s "^f" "fzf^M"
fi

# launch krabby with ctrl + k
# only bind if krabby is installed
if type krabby &>/dev/null; then
  bindkey -s "^k" "krabby random^M"
fi

### END OF KEYBINDINGS ###

### FUNCTIONS ###

# auto run ls (alias for eza) after cd
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

eval $(zoxide init zsh --cmd cd)

### START STARSHIP PROMPT ###
eval "$(starship init zsh)"
