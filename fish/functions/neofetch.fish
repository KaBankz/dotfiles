# note these custom fastfetch configs are stored in ~/.local/share/fastfetch/presets
# most of them are taken from the fastfetch repo
# replace neofetch with the superior fastfetch
function neofetch --wraps='fastfetch --load-config neofetch.jsonc' --description 'alias neofetch=fastfetch --load-config neofetch.jsonc'
    fastfetch --load-config neofetch.jsonc $argv
end
