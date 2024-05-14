# fzf shell integration
runx fzf --fish | source

# start zoxide
# --cmd cd replaces the cd command with zoxide
runx zoxide init fish --cmd cd | source

#! must be excuted last to avoid conflicts with other prompt customizations
# start starship
# --print-full-init prints the full init script directly
# instead of printing a souce command to then print the init script
# this approach provides a faster startup time
runx starship init fish --print-full-init | source
