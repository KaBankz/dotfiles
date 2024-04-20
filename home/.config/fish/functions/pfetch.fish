# note these custom fastfetch configs are stored in ~/.local/share/fastfetch/presets
# most of them are taken from the fastfetch repo
# replace pfetch with the superior fastfetch
function pfetch --wraps='fastfetch --load-config pfetch.jsonc' --description 'alias pfetch=fastfetch --load-config pfetch.jsonc'
    fastfetch --load-config pfetch.jsonc $argv
end
