# function needed for `!!` history expansion.
# used by the `!!` abbreviation in `10-abbr.fish`
function last_history_item --description "Get the last history item"
    echo $history[1]
end
