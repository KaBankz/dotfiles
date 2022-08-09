# Reload .zshrc
alias zload="source $ZDOTDIR/.zshrc"

# Quickly edit zsh config files
alias zedit="nvim $ZDOTDIR"

# Replace vim with neovim
alias vim="nvim"
alias vi="nvim"
alias v="nvim"

# Add windows-like clear
alias cls="clear"

# Replace cat with bat
# paging=never makes bat act like cat
# by not piping large output's into less
alias cat="bat --paging=never"

# Replace find with fd
alias find="fd"

# Replace ls with exa
alias ls="exa --group-directories-first --icons"
alias l="exa -lah --group-directories-first --git --icons"
alias ll="exa -lh --group-directories-first --git --icons"

# Use exa to display dir as a tree
alias tree="exa -T"

# Replace grep with ripgrep
alias grep="rg"

# Auto ls after cd
# builtin uses the "built in" (gnu cd) to avoid conflicts with function name
function cd { builtin cd "$@" && l; }

# Easy cd
alias cd..="cd .."
alias ..="cd .."
alias ...="cd ../.."

# Auto cd after mkdir
function mkcd {
  last=$(eval "echo \$$#")
  if [ ! -n "$last" ]; then
    echo "Enter a directory name"
  elif [ -d $last ]; then
    echo "\`$last' already exists"
  else
    mkdir $@ && cd $last
  fi
}

# Get cheatsheets from cheat.sh
function cheat {
  # $@ = all passed in queries
  queries=$@
  # Replace all spaces from query with +'s
  url="https://cheat.sh/${queries// /+}"
  echo $url
  curl $url
}

alias ch=cheat

# Go to dotfiles dir
alias dot="cd ~/.dotfiles"

# Go to Dev dir
alias dev="cd ~/Dev"

# Confirm before overwrite
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"

# Git aliases
# Create new git repo && add gitmoji commit hooks
alias gini="git init && gitmoji -i"
alias gss="git status -s"
alias glog="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'"
alias gaa="git add ."
alias gcm="git commit -m"
alias gp="git push"
alias gpl="git pull"
alias gf="git fetch"

# Make yarn use custom dir for .yarnrc
alias yarn='yarn --use-yarnrc "$XDG_CONFIG_HOME/yarn/config"'

# Make a brew backup
# --force overwrites any previous Brewfile
# --describe adds package description comments to Brewfile
# --file sets custom backup location. (Location must exist) (Default is current dir)
alias brewbak="brew bundle dump --force --describe --file ~/.dotfiles/pkgs/Brewfile"
