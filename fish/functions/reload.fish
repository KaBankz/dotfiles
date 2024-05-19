function reload --description 'Reload fish configuration'
    for file in ~/.config/fish/conf.d/*.fish
        source $file
    end
end
