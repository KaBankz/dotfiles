# function needed for `!!` history expansion.
# used by the `!!` abbreviation in `10-abbr.fish`
function last_history_item
    echo $history[1]
end
