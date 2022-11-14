#!/usr/bin/env fish

### FISH VARIABLES ####

# set bat as the manpager
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

# fish colors
set fish_color_normal brcyan
set fish_color_autosuggestion "#7d7d7d"
set fish_color_command brcyan
set fish_color_error "#ff6c6b"
set fish_color_param brcyan

### END OF FISH VARIABLES ####

### ENV ###

export XDG_CONFIG_HOME="$HOME"/.config
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_DATA_HOME="$HOME"/.local/share
export XDG_STATE_HOME="$HOME"/.local/state

export EDITOR=nvim

### END OF ENV ###

### STARTUP ###

# load homebrew
# this is up at the top to make sure it's loaded before anything else
# as homebrew manages the majority of the used binaries
# this also only runs if not in a nested shell to avoid duplicated PATH
test "$SHLVL" -eq 1 && eval "$(/opt/homebrew/bin/brew shellenv)"

# load environment variables if not in a nested shell to avoid duplicated PATH
if test -f "$XDG_CONFIG_HOME"/shell/environment && test "$SHLVL" -eq 1
    source "$XDG_CONFIG_HOME"/shell/environment
end

# load aliases
if test -f "$XDG_CONFIG_HOME"/shell/aliases
    source "$XDG_CONFIG_HOME"/shell/aliases
end

### END OF STARTUP ###

### KEYBINDINGS ###

# launch tmux with ctrl + t
bind \ct tmux

# launch ranger with ctrl + r
bind \cr ranger

# launch lazygit with ctrl + g
bind \cg lazygit

# launch fzf with ctrl + f
bind \cf fzf

# show random pokemon with ctrl + k
# the echo stops the name from being print in the prompt
# the commandline -f repaint, repaints the prompt after executing the krabby command
bind \ck 'echo; krabby random; echo; commandline -f repaint'

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
    fish_default_key_bindings

    # vi keybindings
    # fish_vi_key_bindings
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

# auto run onefetch if inside git repo
# --on-variable is a fish builtin that changes whenever the directory changes
# so this function will run whenever the directory changes
function auto_onefetch --on-variable PWD
    # check if .git/ exists
    if test -d .git
        onefetch
    end
end

# auto run ls (alias for exa) after cd
# --on-variable is a fish builtin that changes whenever the directory changes
# so this function will run whenever the directory changes
function autols --on-variable PWD
    ls
end

# function for creating a backup file
# ex: bak file.txt
# result: copies file as file.txt.bak
# TODO: add a flag that will create the backup in ~/.local/backups
function bak --argument filename
    cp "$filename" "$filename".bak
end

### END OF FUNCTIONS ###

### START STARSHIP PROMPT ###
starship init fish | source
