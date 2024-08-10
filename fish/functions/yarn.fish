function yarn --wraps yarn --description "Yarn with XDG Base Directory support"
    runx command yarn --use-yarnrc $XDG_CONFIG_HOME/yarn/config $argv
end
