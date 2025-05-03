function ls --wraps eza --description "eza: a modern replacement for ls"
    runx eza -laagH \
        --group-directories-first \
        --git \
        --icons \
        --time-style "+%h %e  %Y"\n"%h %e %H:%M" \
        $argv || command ls -lah --color $argv
end
