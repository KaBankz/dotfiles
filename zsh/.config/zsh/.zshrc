# Clear "last login" message from mac shell startup
clear

# TODO: man zshoptions and add in some options

# Set zsh history file dir
# Warning, the $XDG_STATE_HOME/zsh dir may have to exist for this to work
# not exactly sure, more testing required
export HISTFILE="$XDG_STATE_HOME/zsh/history"

# Homebrew completions
# Must be before compinit
if type brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

# Enable zsh autocompletions && start and set completion dump path
autoload -Uz compinit && compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION

# Set autocompletion cache path
zstyle ':completion:*' cache-path $XDG_CACHE_HOME/zsh/zcompcache

# Case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Bling
# neofetch
pfetch

# Load alias file if it exists
[ -f $ZDOTDIR/aliases.zsh ] && source $ZDOTDIR/aliases.zsh

# Load nvm
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
# Load nvm bash_completion
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

# No longer needed as now it is directly added to the PATH below
# # Source rust
# source $CARGO_HOME/env

export PATH=$PATH:"$XDG_DATA_HOME/fvm/default/bin":"$(yarn global bin)":"$CARGO_HOME/bin":"$PNPM_HOME"

# Keybindings
# Use emacs mode becasue vi mode does not work with iterm2 natural text editing keybindings
# Also because I have EDITOR defined as nvim, zsh auto uses vi mode, so this overrides that
bindkey -e

# Open ranger with ctrl + o
bindkey -s '^o' 'ranger^M'

################################################################################
# WARNING:
#   zplug causes xcodebuild to run at startup, which causes the terminal
#   to hang for a few seconds
#   This is a issue with zplug, and is not a problem with zsh
#   I have done extensive testing, and zplug just keeps on calling xcodebuild
#   on startup, which causes the terminal to hang
# SOLUTION:
#   Migrate from zplug to zinit
################################################################################
# # zplug Plugins
# export ZPLUG_HOME=/opt/homebrew/opt/zplug
# source $ZPLUG_HOME/init.zsh

# zplug "zsh-users/zsh-completions"
# zplug "zsh-users/zsh-autosuggestions"
# zplug "zsh-users/zsh-syntax-highlighting", defer:2

# # Install plugins if there are plugins that have not been installed
# if ! zplug check --verbose; then
#   printf "Install? [y/N]: "
#   if read -q; then
#     echo
#     zplug install
#   fi
# fi

# # Then, source plugins and add commands to $PATH
# zplug load

# Load starship prompt
# Keep at end of file
eval "$(starship init zsh)"

# Setting fish as interactive shell
# This is at the bottom so it runs after zsh loads all its env vars
# from zprofile this allows fish to access the env vars
exec fish
