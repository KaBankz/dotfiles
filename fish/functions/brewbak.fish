# make a brewfile backup of all installed packages
# --force overwrites any previous Brewfile
function brewbak --wraps='brew bundle dump --force --formula --casks --taps --file ~/.dotfiles/pkgs/Brewfile' --description 'alias brewbak=brew bundle dump --force --formula --casks --taps --file ~/.dotfiles/pkgs/Brewfile'
    runx brew bundle dump --force --formula --casks --taps --file ~/.dotfiles/pkgs/Brewfile $argv
end
