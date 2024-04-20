# confirm before overwriting something
function cp --description 'alias cp=cp -i'
    command cp -i $argv
end
