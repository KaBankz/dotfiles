# confirm before overwriting something
function rm --description 'alias rm=rm -i'
    command rm -i $argv
end
