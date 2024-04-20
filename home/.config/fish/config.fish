# launch fzf with ctrl + f
# only bind if fzf is installed
type -q fzf && bind \cf fzf

# show random pokemon with ctrl + k
# the echo stops the name from being print in the prompt
# the commandline -f repaint, repaints the prompt after executing the krabby command
# only bind if krabby is installed
if type -q krabby
    bind \ck 'echo; krabby random; echo; commandline -f repaint'
end

# homebrew command not found
set -g HB_CNF_HANDLER (brew --repository)"/Library/Taps/homebrew/homebrew-command-not-found/handler.fish"
test -f $HB_CNF_HANDLER && source $HB_CNF_HANDLER

# supresses fish's intro message
function fish_greeting
    # pokemon shell colorscripts cargo package
    # --info flag prints the pokemon's pokedex entry
    type -q krabby && krabby random --info
end

# set keybinding mode
function fish_user_key_bindings
    # emacs keybindings
    fish_default_key_bindings

    # vi keybindings
    # fish_vi_key_bindings
end

# function needed for `!!` history expansion.
# used by the `!!` abbreviation in `10-abbr.fish`
function last_history_item
    echo $history[1]
end

# auto run onefetch if inside git repo
# --on-variable is a fish builtin that changes whenever the directory changes
# so this function will run whenever the directory changes
function auto_onefetch --on-variable PWD
    # check if .git/ exists and is a git repo and if onefetch is installed
    if test -d .git && git rev-parse --git-dir >/dev/null 2>&1 && type -q onefetch
        onefetch
    end
end

# auto run ls (alias for eza) after cd
# --on-variable is a fish builtin that changes whenever the directory changes
# so this function will run whenever the directory changes
function autols --on-variable PWD
    ls
end

# auto expand ".." and longer varients to cd .. (or more)
# used by the `dotdot` abbreviation in `10-abbr.fish`
function multicd
    echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
end

# auto cd after mkdir
# taken from https://fishshell.com/docs/current/cmds/function.html#example
function mkcd -d "Create a directory and set CWD"
    command mkdir -pv $argv
    if test $status = 0
        switch $argv[(count $argv)]
            case '-*'

            case '*'
                cd $argv[(count $argv)]
                return
        end
    end
end

# start zoxide if installed
type -q zoxide && zoxide init fish | source

#! must be at the end of the file
# start starship if installed
# --print-full-init prints the full init script directly
# instead of printing a souce command to then print the init script
# this approach provides a faster startup time
type -q starship && starship init fish --print-full-init | source
