# replace ls with eza
alias ls="eza -lah --group-directories-first --git --icons"

# use eza to display dir as a tree
alias tree="eza -T"

# use bat instead of cat
alias cat="bat"

# confirm before overwriting something
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"

# note these custom fastfetch configs are stored in ~/.local/share/fastfetch/presets
# most of them are taken from the fastfetch repo
# replace neofetch with the superior fastfetch
alias neofetch="fastfetch --load-config neofetch.jsonc"
# replace paleofetch with the superior fastfetch
alias paleofetch="fastfetch --load-config paleofetch.jsonc"
# replace pfetch with the superior fastfetch
alias pfetch="fastfetch --load-config pfetch.jsonc"

# git
alias glog="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'"

# make yarn use custom dir for .yarnrc to follow XDG spec
alias yarn="yarn --use-yarnrc '$XDG_CONFIG_HOME/yarn/config'"

# make a brewfile backup of all installed packages
# --force overwrites any previous Brewfile
# --describe adds package description comments to Brewfile
# --file sets custom backup location. (Location must exist) (Default is current dir)
alias brewbak="brew bundle dump --force --describe --file ~/.dotfiles/pkgs/Brewfile"
