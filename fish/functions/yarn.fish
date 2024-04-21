# make yarn use custom dir for .yarnrc to follow XDG spec
function yarn --description alias\ yarn=yarn\ --use-yarnrc\ \'/Users/zakee/.config/yarn/config\'
    command yarn --use-yarnrc '/Users/zakee/.config/yarn/config' $argv
end
