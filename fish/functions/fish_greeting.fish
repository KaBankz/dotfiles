function fish_greeting
    # krabby only works in truecolor terminals
    if test "$COLORTERM" = truecolor
        # pokemon shell colorscripts cargo package
        # --info flag prints the pokemon's pokedex entry
        runx mise x -q cargo:krabby -- krabby random --info || runx krabby random --info
    else
        runx fastfetch -c neofetch
    end
end
