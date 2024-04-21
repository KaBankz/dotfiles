function runx --description 'Run a command only if it exists'
    if type -q $argv[1]
        $argv
    end
end
