# replace ls with eza
function ls --wraps='eza -lah --group-directories-first --git --icons' --description 'alias ls=eza -lah --group-directories-first --git --icons'
    runx eza -lah --group-directories-first --git --icons $argv || command ls -lah --color $argv
end
