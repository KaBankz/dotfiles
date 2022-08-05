# Clear "last login" message from mac shell startup
clear
# Bling
# neofetch
# pfetch
# pokemon shell colorscript
# krabby random --no-title

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

# Sourcing zinit before compinit
source /opt/homebrew/opt/zinit/zinit.zsh

# Enable zsh autocompletions && start and set completion dump path
autoload -Uz compinit && compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION

# Set autocompletion cache path
zstyle ':completion:*' cache-path $XDG_CACHE_HOME/zsh/zcompcache

# Case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Load alias file if it exists
[ -f $ZDOTDIR/aliases.zsh ] && source $ZDOTDIR/aliases.zsh

# Load asdf
source /opt/homebrew/opt/asdf/libexec/asdf.sh

# No longer needed as now it is directly added to the PATH below
# # Source rust
# source $CARGO_HOME/env

export PATH=$PATH:"$HOME/.local/bin":"$(yarn global bin)":"$CARGO_HOME/bin":"$PNPM_HOME"

# Keybindings
# Use emacs mode becasue vi mode does not work with iterm2 natural text editing keybindings
# Also because I have EDITOR defined as nvim, zsh auto uses vi mode, so this overrides that
bindkey -e

# Open ranger with ctrl + o
bindkey -s '^o' 'ranger^M'

zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting

# Load starship prompt
# Keep at end of file
eval "$(starship init zsh)"

# Setting fish as interactive shell
# This is at the bottom so it runs after zsh loads all its env vars
# from zprofile this allows fish to access the env vars
exec fish
