if status is-interactive
    and type -q tmux
    and not set -q TMUX
    exec tmux new-session -As main
end

set -U fish_greeting # Disable greeting

### ENV
set -gx XDG_CONFIG_HOME "$HOME"/.config
set -gx XDG_CACHE_HOME "$HOME"/.cache
set -gx XDG_DATA_HOME "$HOME"/.local/share
set -gx XDG_STATE_HOME "$HOME"/.local/state

if type -q nvim
    set -gx EDITOR nvim
else
    set -gx EDITOR vim
end

set -gx LESSHISTFILE -
set -gx DOCKER_CONFIG "$XDG_CONFIG_HOME"/docker

fish_add_path -P "$HOME"/.local/bin

### FUNCTIONS
function fish_prompt # [user@hostname pwd]$
    set_color red -o
    printf '['

    set_color yellow -o
    printf '%s' $USER

    set_color green -o
    printf '@'

    set_color blue -o
    printf '%s ' $hostname

    set_color magenta -o
    printf '%s' (prompt_pwd)

    set_color red -o
    printf ']'

    if fish_is_root_user
        set_color cyan -o
        printf '$$ '
    else
        set_color normal -o
        printf '$ '
    end
end

function mkcd -d "Create a directory and set CWD"
    command mkdir -pv $argv
    if test $status = 0
        switch $argv[(count $argv)]
            case '-*'

            case '*'
                cd $argv[(count $argv)]
                return
        end
    end
end

function multi_cd
    echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
end

function auto_ls --on-variable PWD
    ls
end

### ALIASES
if type -q batcat
    alias cat batcat
end

if type -q exa
    alias ls "exa -lah --group-directories-first --icons"
    alias tree "exa -Ta"
end

alias cip "curl -sS https://ipinfo.io"
alias fload "source ~/.config/fish/config.fish"
alias fedit "$EDITOR ~/.config/fish/config.fish"

### ABBREVIATIONS
abbr -ag l ls
abbr -ag v nvim
abbr -ag v. nvim .
abbr -ag aup "sudo apt update && sudo apt upgrade"
abbr -ag edc cd /mnt/seagate-8tb
abbr -ag dpa docker ps -a
abbr -ag dia docker image ls -a
abbr -ag dva docker volume ls
abbr -ag dna docker network ls
abbr -ag ds docker start
abbr -ag dk docker kill
abbr -ag dr docker restart
abbr -ag dl docker logs -f
abbr -ag drm docker rm
abbr -ag dirm docker image rm
abbr -ag deit docker exec -it
abbr -ag dcu docker compose up -d
abbr -ag dcb docker compose build
abbr -ag dcd docker compose down
abbr -ag dcp docker compose pull
