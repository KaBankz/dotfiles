# fish color scheme
set fish_color_normal brcyan
set fish_color_autosuggestion "#7d7d7d"
set fish_color_command brcyan
set fish_color_error "#ff6c6b"
set fish_color_param brcyan

# # start tmux on iterm2 startup
# # only run if tmux is installed
# if test "$TERM_PROGRAM" = "iTerm.app" && type -q tmux
#     tmux attach || tmux
# end

# launch tmux with ctrl + t
# only bind if tmux is installed
if type -q tmux
    bind \ct tmux
end

# launch fzf with ctrl + f
# only bind if fzf is installed
if type -q fzf
    bind \cf fzf
end

# show random pokemon with ctrl + k
# the echo stops the name from being print in the prompt
# the commandline -f repaint, repaints the prompt after executing the krabby command
# only bind if krabby is installed
if type -q krabby
    bind \ck 'echo; krabby random; echo; commandline -f repaint'
end

# homebrew command not found
set HB_CNF_HANDLER (brew --repository)"/Library/Taps/homebrew/homebrew-command-not-found/handler.fish"
if test -f $HB_CNF_HANDLER
   source $HB_CNF_HANDLER
end

# supresses fish's intro message
function fish_greeting
    # clear the screen on startup to remove macos's "last login" message
    clear

    if type -q krabby
        # pokemon shell colorscripts cargo package
        krabby random
    end
end

# set keybinding mode
function fish_user_key_bindings
    # emacs keybindings
    fish_default_key_bindings

    # vi keybindings
    # fish_vi_key_bindings
end

# function needed for !! used in abbr below
function last_history_item
    echo $history[1]
end

# auto run onefetch if inside git repo
# --on-variable is a fish builtin that changes whenever the directory changes
# so this function will run whenever the directory changes
function auto_onefetch --on-variable PWD
    # check if .git/ exists and onefetch is installed
    if test -d .git && type -q onefetch
        onefetch
    end
end

# auto run ls (alias for exa) after cd
# --on-variable is a fish builtin that changes whenever the directory changes
# so this function will run whenever the directory changes
function autols --on-variable PWD
    ls
end

# auto expand ".." and longer varients to cd .. (or more)
# used by abbr below
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
if type -q zoxide
    zoxide init fish | source
end

# start rtx if installed
if type -q rtx
    rtx activate fish | source
end

# must be at the end of the file
# start starship if installed
if type -q starship
    starship init fish | source
end
