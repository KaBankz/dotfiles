function wget --description 'alias wget=wget --hsts-file=$XDG_DATA_HOME/wget-hsts'
    runx command wget --hsts-file=$XDG_DATA_HOME/wget-hsts $argv
end
