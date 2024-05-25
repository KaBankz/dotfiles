# auto expand ".." and longer variants to cd .. (or more)
# used by the `dotdot` abbreviation in `10-abbr.fish`
function multi_cd
    echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
end
