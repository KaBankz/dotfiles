# fzf shell integration
runx fzf --fish | source

# start zoxide
# --cmd cd replaces the cd command with zoxide
runx zoxide init fish --cmd cd | source

# start atuin without up arrow history
runx atuin init fish --disable-up-arrow | source

# source 1Password plugins
if test -f $HOME/.config/op/plugins.sh
    source $HOME/.config/op/plugins.sh
end

#! must be executed last to avoid conflicts with other prompt customizations
# start starship
runx starship init fish | source

# update fish completions every 30 days
set -l last_completion_update_file $HOME/.local/share/fish/.last_completion_update

if test -f $last_completion_update_file
    if test (math (date +%s) - (cat $last_completion_update_file)) -ge 2592000
        echo "Updating fish completions"
        # this updates fish completions based on manpages
        fish_update_completions
        date +%s >$last_completion_update_file
    end
else
    date +%s >$last_completion_update_file
end
