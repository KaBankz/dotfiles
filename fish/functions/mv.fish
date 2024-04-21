# confirm before overwriting something
function mv --description 'alias mv=mv -i'
    command mv -i $argv
end
