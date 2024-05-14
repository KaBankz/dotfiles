function cat --wraps=bat --description 'alias cat=bat'
    runx bat $argv || command cat $argv
end
