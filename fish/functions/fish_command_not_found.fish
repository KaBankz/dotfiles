function fish_command_not_found
    set -l cmd $argv[1]
    set -l txt

    if not contains -- "$cmd" -h --help --usage "-?"
        set txt (brew which-formula --explain $cmd 2> /dev/null)
    end

    if test -z "$txt"
        __fish_default_command_not_found_handler $cmd
    else
        string collect $txt
    end
end
