# use eza to display dir as a tree
function tree --wraps='eza -Ta --git-ignore' --description 'alias tree=eza -Ta --git-ignore'
    eza -Ta --git-ignore $argv
end
