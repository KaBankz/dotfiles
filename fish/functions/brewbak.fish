# --force overwrites any previous Brewfile
function brewbak --wraps "brew bundle" --description "Make a Brewfile backup of all installed packages"
    runx brew bundle dump --force --formula --casks --taps --file ~/.dotfiles/pkgs/Brewfile $argv
end
