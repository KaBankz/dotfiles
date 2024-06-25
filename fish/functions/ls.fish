# replace ls with eza
function ls --wraps='eza -lah --group-directories-first --git --icons --group --time-style "+%h %d %H:%M"' --description 'alias ls=eza -lah --group-directories-first --git --icons --group --time-style "+%h %d %H:%M"'
    runx eza -lah --group-directories-first --git --icons --group --time-style "+%h %d %H:%M" $argv || command ls -lah --color $argv
end
