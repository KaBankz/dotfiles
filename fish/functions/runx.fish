function runx --description 'Run a command only if it exists'
    # handle `command` prefix
    if test $argv[1] = command
        if type -q $argv[2]
            # using eval here because without it, only `command` is executed
            # instead of the entire command
            eval "$argv"
        else
            echo "[runx] Command not found: $argv[2]"
            return 1
        end
    else if type -q $argv[1]
        $argv
    else
        echo "[runx] Command not found: $argv[1]"
        return 1
    end
end
