function fish_greeting
    # krabby only works in truecolor terminals
    if test "$COLORTERM" = truecolor
        # pokemon shell colorscripts cargo package
        # --info flag prints the pokemon's pokedex entry
        runx krabby random --info
    else
        runx neofetch
    end
end
