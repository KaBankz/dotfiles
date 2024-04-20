# auto cd after mkdir
# taken from https://fishshell.com/docs/current/cmds/function.html#example
function mkcd -d "Create a directory and set CWD"
    command mkdir -pv $argv
    if test $status = 0
        switch $argv[(count $argv)]
            case '-*'

            case '*'
                cd $argv[(count $argv)]
                return
        end
    end
end
