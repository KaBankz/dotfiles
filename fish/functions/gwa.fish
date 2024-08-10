function gwa --wraps "git worktree add" --description "Add a new git worktree"
    # remove invalid characters from the directory name
    set -l dir (string replace -r '[^a-zA-Z0-9_]' '-' $argv)
    git worktree add $dir $argv
end
