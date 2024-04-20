# replace ls with eza
function ls --wraps='eza -lah --group-directories-first --git --icons' --description 'alias ls=eza -lah --group-directories-first --git --icons'
    eza -lah --group-directories-first --git --icons $argv
end
