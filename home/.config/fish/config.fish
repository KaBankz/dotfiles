# fish config explained
#
# example fish config dir structure
#
# fish
# ├── completions/ - contains custom completion files for commands
# ├── conf.d/ - contains config files for fish loaded in alphanumeric order
# ├── config.fish - legacy fish config file
# ├── fish_variables - autogenerated file of variables set by fish
# └── functions/ - contains functions that are autoloaded by fish (lazy loaded)
#
# these configs are loaded in the following order
# 1. conf.d/
# 2. functions/
# 3. config.fish
# 4. fish_variables
# 5. completions/
#
# unlike most shells that have a single monolithic config file, fish reccomends
# splitting up the config into multiple files for better performance
# but, for new users, it is easier to have a single config file so fish does
# have a config.fish file that can contain all the configurations instead
#
# for advanced users or those who care about performace, don't use config.fish
# and instead use the conf.d/ and functions/ directories as described above
#
# all your config (env, abbr, etc) should be in conf.d/ and your functions
# should be in functions/ and fish will automatically load them as needed
#
# note: dont use `alias` in your config, as that just creates a function in the
# background which is slow, instead use `abbr` where possible and use functions
# for more complex aliases.
# to convert aliases to functions just add the `-s` flag to the alias
# ex: `alias ls="ls -lah"` becomes `alias -s ls="ls -lah"`
# note: only run this once, as this will write a function to the functions/ directory
# now remove all traces of `alias` from your config
# if you want to add an alias in the future just run `alias -s <alias> <command>`
# you can then edit and remove them from the functions/ directory as needed
#
# config.fish should only exist if you need to override the above configs as it
# is loaded after the conf.d/ and functions/ directories
#
# fish_variables is autogenerated and should not be manually edited
# completions/ is for custom completions, if you need them you already know what to do
#
# the ideal fish config structure is to have all your configs in conf.d/
# and all your functions in functions/ with no config.fish file
#
# use this fish config as a reference for your own fish config

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

#! must be excuted last to avoid conflicts with other prompt customizations
# start starship if installed
# --print-full-init prints the full init script directly
# instead of printing a souce command to then print the init script
# this approach provides a faster startup time
type -q starship && starship init fish --print-full-init | source
