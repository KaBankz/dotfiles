# expand .. to cd .. (and so on)
abbr -ag dotdot --regex '^\.\.+$' --function multi_cd

# l -> ls
abbr -ag l ls

# edit shell configs
abbr -ag zedit $EDITOR $ZDOTDIR
abbr -ag fedit $EDITOR $XDG_CONFIG_HOME/fish

# homebrew
abbr -ag brw brew
abbr -ag rbew brew
abbr -ag brwe brew

# cursor easy
abbr -ag c cursor
abbr -ag c. cursor .

# lazygit
abbr -ag lg lazygit

# bun install easy
abbr -ag buni bun install

# mise easy
abbr -ag mr mise run

# zed easy
abbr -ag z. zed-preview .

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
abbr -ag dcl docker compose logs -f

# opencode
abbr -ag oc opencode

# claude code
abbr -ag cc claude --dangerously-skip-permissions

# git
abbr -ag gss git status -s
abbr -ag ga git add
abbr -ag gaa git add -A
abbr -ag gap git add -p
abbr -ag gcm git commit -m
abbr -ag gca git commit --amend
abbr -ag gp git push
abbr -ag gpf git push --force-with-lease
abbr -ag gpl git pull
abbr -ag gf git fetch
abbr -ag gd git diff
abbr -ag gb git branch
abbr -ag gc git checkout
abbr -ag gs git switch
abbr -ag gsc git switch -c
abbr -ag grb git rebase
abbr -ag gsh git stash
abbr -ag gshp git stash pop
abbr -ag grs git reset
abbr -ag gw git worktree
abbr -ag gwa git worktree add
abbr -ag gwl git worktree list
abbr -ag gwr git worktree remove
