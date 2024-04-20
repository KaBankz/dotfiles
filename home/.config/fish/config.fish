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

# the following functions are here instead of in the functions directory
# because they utilize event handlers which autoloading does not support

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
function auto_ls --on-variable PWD
    ls
end

# start zoxide if installed
type -q zoxide && zoxide init fish | source

#! must be at the end of the file
# start starship if installed
# --print-full-init prints the full init script directly
# instead of printing a souce command to then print the init script
# this approach provides a faster startup time
type -q starship && starship init fish --print-full-init | source
