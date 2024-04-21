# note these custom fastfetch configs are stored in ~/.local/share/fastfetch/presets
# most of them are taken from the fastfetch repo
# replace paleofetch with the superior fastfetch
function paleofetch --wraps='fastfetch --load-config paleofetch.jsonc' --description 'alias paleofetch=fastfetch --load-config paleofetch.jsonc'
    fastfetch --load-config paleofetch.jsonc $argv
end
