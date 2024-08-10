function ls --wraps eza --description "eza: a modern replacement for ls"
    runx eza -laa --group-directories-first --git --icons --group --links --time-style "+%h %e  %Y"\n"%h %e %H:%M" $argv || command ls -lah --color $argv
end
