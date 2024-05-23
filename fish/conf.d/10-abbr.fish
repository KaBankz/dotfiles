# history expansion
abbr -ag !! --position anywhere --function last_history_item

# expand .. to cd .. (and so on)
abbr -ag dotdot --regex '^\.\.+$' --function multi_cd

# add windows-like clear
abbr -ag cls clear

# l -> ls
abbr -ag l ls

# edit shell configs
abbr -ag zedit $EDITOR $ZDOTDIR
abbr -ag fedit $EDITOR $XDG_CONFIG_HOME/fish

# homebrew
abbr -ag brw brew
abbr -ag rbew brew

# vscode easy
abbr -ag c code
abbr -ag c. code .

# zed easy
abbr -ag z. zed .

# nvim
abbr -ag v nvim
abbr -ag v. nvim .
abbr -ag vi nvim
abbr -ag vim nvim

# docker
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

# git
abbr -ag gini git init
abbr -ag gss git status -s
abbr -ag ga git add
abbr -ag gaa git add -A
abbr -ag gcm git commit -m
abbr -ag gp git push
abbr -ag gpl git pull
abbr -ag gplr git pull --rebase
abbr -ag gf git fetch
abbr -ag gd git diff
abbr -ag gb git branch
abbr -ag gc git checkout
abbr -ag gs git switch

# yt-dlp
abbr -ag yt yt-dlp

# zellij
abbr -ag zz zellij

# ollama
abbr -ag ol ollama

# zoxide
abbr -ag z cd
