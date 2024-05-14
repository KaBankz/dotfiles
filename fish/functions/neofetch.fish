# replace neofetch with the superior fastfetch
function neofetch --wraps='fastfetch -c neofetch' --description 'alias neofetch=fastfetch -c neofetch'
    runx fastfetch -c neofetch $argv
end
