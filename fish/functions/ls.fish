# replace ls with eza
function ls --wraps='eza -laa --group-directories-first --git --icons --group --links --time-style "+%h %d %H:%M"' --description 'alias ls=eza -laa --group-directories-first --git --icons --group --links --time-style "+%h %d %H:%M"'
    runx eza -laa --group-directories-first --git --icons --group --links --time-style "+%h %d %H:%M" $argv || command ls -lah --color $argv
end
