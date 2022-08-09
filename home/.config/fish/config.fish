### FISH VARIABLES ####

# set bat as the manpager
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

# fish colors
set fish_color_normal brcyan
set fish_color_autosuggestion '#7d7d7d'
set fish_color_command brcyan
set fish_color_error '#ff6c6b'
set fish_color_param brcyan

### END OF FISH VARIABLES ####


### KEYBINDINGS ###

# launch tmux with ctrl + t
bind \ct tmux

# launch ranger with ctrl + r
bind \cr ranger

# launch lazygit with ctrl + g
bind \cg lazygit

### END OF KEYBINDINGS ###


### FISH FUNCTIONS ###

# supresses fish's intro message
function fish_greeting
    # clear the screen on startup to remove macos's "last login" message
    clear
    # pokemon shell colorscripts
    krabby random
end

# set keybinding mode
function fish_user_key_bindings
    # emacs keybindings
    # fish_default_key_bindings

    # vi keybindings
    fish_vi_key_bindings
end

# function needed for !!
function __history_previous_command
    switch (commandline -t)
        case "!"
            commandline -t $history[1]
            commandline -f repaint
        case "*"
            commandline -i !
    end
end

# function needed for !$
function __history_previous_command_arguments
    switch (commandline -t)
        case "!"
            commandline -t ""
            commandline -f history-token-search-backward
        case "*"
            commandline -i '$'
    end
end

# keybindings for !! and !$
if [ $fish_key_bindings = fish_vi_key_bindings ]
    bind -Minsert ! __history_previous_command
    bind -Minsert '$' __history_previous_command_arguments
else
    bind ! __history_previous_command
    bind '$' __history_previous_command_arguments
end

# load asdf
source /opt/homebrew/opt/asdf/libexec/asdf.fish

# OLD CODE
# auto ls after cd
# builtin uses the default cd to avoid conflicts with function name
# function cd
#     # if no directory is specified (arguments less than 1), just run cd and l (alias for exa)
#     # else run cd with the arguments then run l (alias for exa)
#     if test (count $argv) -lt 1
#         builtin cd && l
#     else
#         builtin cd "$argv" && l
#     end
# end

# auto run onefetch if inside git repo
# --on-variable is a fish builtin that changes whenever the directory changes
# so this function will run whenever the directory changes
function auto_onefetch --on-variable PWD
    # check if .git/ exists
    if test -d .git
        onefetch
    end
end

# auto run l (alias for exa) after cd
# --on-variable is a fish builtin that changes whenever the directory changes
# so this function will run whenever the directory changes
function autols --on-variable PWD
    l
end

# get cheatsheets from cheat.sh
function cheatsheet
    # $argv = all passed in queries
    # concatnate all passed in queries into one string with "+"" between each query
    # then append that to the cheat.sh url and curl it
    set url "https://cheat.sh/$(string join '+' $argv)"
    echo $url
    curl $url
end

# function for creating a backup file
# ex: bak file.txt
# result: copies file as file.txt.bak
# TODO: add a flag that will create the backup in ~/.local/backups
function bak --argument filename
    cp $filename $filename.bak
end

### END OF FUNCTIONS ###


### ALIASES ###

# add windows-like clear
alias cls="clear"

# edit shell configs
alias bedit='nvim ~/.bashrc'
alias zedit='nvim $ZDOTDIR'
alias fedit='nvim $XDG_CONFIG_HOME/fish'

# reload shell configs
alias bload='source ~/.bashrc'
alias zload='source $ZDOTDIR/.zshrc'
alias fload='source $XDG_CONFIG_HOME/fish/config.fish'

# go to dotfiles dir
alias dot="cd ~/.dotfiles"

# go to development dir
alias dev="cd ~/Dev"

# run cheat.sh function
alias ch=cheatsheet
alias cheat=cheatsheet

# navigation
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# replace vim and vi with neovim
alias vim="nvim"
alias vi="nvim"
alias v="nvim"

# replace cat with bat
# --paging=never makes bat act like cat
# by not piping large output's into less
alias cat="bat --paging=never"

# replace find with fd
alias find="fd"

# replace grep with ripgrep
alias grep="rg"

# replace ls with exa
alias l="exa -lah --group-directories-first --git --icons"
alias ls="exa --group-directories-first --icons"
alias la="exa -a --group-directories-first --icons"
alias ll="exa -lh --group-directories-first --git --icons"

# use exa to display dir as a tree
alias tree="exa -T"

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# git aliases
# create new git repo && add gitmoji commit hooks
alias gini="git init && gitmoji -i"
alias gss="git status -s"
alias glog="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'"
alias ga='git add'
alias gaa="git add ."
alias gcm="git commit -m"
alias gp="git push"
alias gpl="git pull"
alias gf="git fetch"

# make yarn use custom dir for .yarnrc to follow XDG spec
alias yarn='yarn --use-yarnrc "$XDG_CONFIG_HOME/yarn/config"'

# termbin
alias tb="nc termbin.com 9999"

# make a brewfile backup of all installed packages
# --force overwrites any previous Brewfile
# --describe adds package description comments to Brewfile
# --file sets custom backup location. (Location must exist) (Default is current dir)
alias brewbak="brew bundle dump --force --describe --file ~/.dotfiles/pkgs/Brewfile"

### END OF ALIASES ###


### START STARSHIP PROMPT ###
starship init fish | source
