function cat --wraps bat --description "Cat with wings"
    runx bat $argv || command cat $argv
end
