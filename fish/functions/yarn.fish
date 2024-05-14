function yarn --description alias\ yarn=yarn\ --use-yarnrc\ \'$XDG_CONFIG_HOME/yarn/config\'
    runx command yarn --use-yarnrc $XDG_CONFIG_HOME/yarn/config $argv
end
