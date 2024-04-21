# use bat instead of cat
function cat --wraps=bat --description 'alias cat=bat'
    bat $argv
end
