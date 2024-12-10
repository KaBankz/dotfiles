# DISCLAIMER:
# Fishes aliases are just helper functions that auto create fish functions
# in the background. So, by definition they are going to be slower than
# creating the functions manually since you're going through a middleman.
# But, the slowdown is negligible and the convenience is worth it.

alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"
alias glog="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'"
alias gsp="gs"
alias tree="eza -Ta --git-ignore"
alias pfetch="fastfetch -c pfetch"
alias neofetch="fastfetch -c neofetch"
alias wget="wget --hsts-file=$XDG_DATA_HOME/wget-hsts"
