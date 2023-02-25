# replace ls with exa
alias ls="exa -lah --group-directories-first --git --icons"

# use exa to display dir as a tree
alias tree="exa -T"

# confirm before overwriting something
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"

# git
alias glog="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'"

# make yarn use custom dir for .yarnrc to follow XDG spec
alias yarn="yarn --use-yarnrc '$XDG_CONFIG_HOME/yarn/config'"

# termbin
alias tb="nc termbin.com 9999"

# make a brewfile backup of all installed packages
# --force overwrites any previous Brewfile
# --describe adds package description comments to Brewfile
# --file sets custom backup location. (Location must exist) (Default is current dir)
alias brewbak="brew bundle dump --force --describe --file ~/.dotfiles/pkgs/Brewfile"
