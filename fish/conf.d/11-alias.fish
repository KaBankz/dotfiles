# DISCLAIMER:
# Fishes aliases are just helper functions that auto create fish functions
# in the background. So, by definition they are going to be slower than
# creating the functions manually since you're going through a middleman.
# But, the slowdown is negligible and the convenience is worth it.

alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -iv"

alias glog="git log \
  --graph \
  --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'"

alias gsp="gs"
alias tree="runx eza -Ta"
alias pfetch="runx fastfetch -c pfetch"
alias neofetch="runx fastfetch -c neofetch"
alias wget="runx wget --hsts-file=$XDG_DATA_HOME/wget-hsts"
