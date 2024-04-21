function glog --wraps=git\ log\ --graph\ --pretty=\'\%Cred\%h\%Creset\ -\%C\(auto\)\%d\%Creset\ \%s\ \%Cgreen\(\%ar\)\ \%C\(bold\ blue\)\<\%an\>\%Creset\' --description alias\ glog=git\ log\ --graph\ --pretty=\'\%Cred\%h\%Creset\ -\%C\(auto\)\%d\%Creset\ \%s\ \%Cgreen\(\%ar\)\ \%C\(bold\ blue\)\<\%an\>\%Creset\'
    git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' $argv
end
