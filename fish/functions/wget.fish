function wget --wraps wget --description "wget with XDG Base Directory support"
    runx command wget --hsts-file=$XDG_DATA_HOME/wget-hsts $argv
end
