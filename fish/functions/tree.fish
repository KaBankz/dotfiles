# use eza to display dir as a tree
function tree --wraps='eza -T' --description 'alias tree=eza -T'
    eza -T $argv
end
