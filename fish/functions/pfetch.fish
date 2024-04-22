# replace pfetch with the superior fastfetch
function pfetch --wraps='fastfetch -c pfetch' --description 'alias pfetch=fastfetch -c pfetch'
    fastfetch -c pfetch $argv
end
