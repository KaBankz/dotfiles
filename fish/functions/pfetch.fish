# replace pfetch with the superior fastfetch
function pfetch --wraps='fastfetch -c pfetch' --description 'alias pfetch=fastfetch -c pfetch'
    runx fastfetch -c pfetch $argv
end
