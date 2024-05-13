# Simulate the behavior of the path_helper command on macOS
# Original: /usr/libexec/path_helper

# PATH Lookup
# /etc/paths
# /etc/paths.d/*

# MANPATH Lookup
# /etc/manpaths
# /etc/manpaths.d/*

# Default MANPATH on macOS if MANPATH is unset
# ref: /etc/man.conf
# /usr/share/man -- Included in /etc/manpaths
# /usr/local/share/man -- Included in /etc/manpaths
# /usr/X11/man
# /Library/Apple/usr/share/man

function path_helper -d "Simulate the behavior of the path_helper command on macOS"
    # https://github.com/fish-shell/fish-shell/issues/5774#issuecomment-477482037
    set -l allargs (count $argv) # count all arguments before parsing flags

    argparse p/path m/manpath h/help -- $argv
    or return # return if parsing fails

    if set -ql _flag_help
        printf "Simulate the behavior of the path_helper command on macOS\n"
        printf "\n"
        printf "Usage: path_helper [-p | --path] [-m | --manpath] [-h | --help]\n"
        printf "  Original: /usr/libexec/path_helper\n"
        printf "\n"
        printf "Options:\n"
        printf "  -p, --path    Print the PATH environment variable\n"
        printf "  -m, --manpath Print the MANPATH environment variable\n"
        printf "  -h, --help    Print this help message\n"
        printf "\n"
        printf "PATH Lookup\n"
        printf "  /etc/paths\n"
        printf "  /etc/paths.d/*\n"
        printf "\n"
        printf "MANPATH Lookup\n"
        printf "  /etc/manpaths\n"
        printf "  /etc/manpaths.d/*\n"
        printf "\n"
        printf "Default MANPATH on macOS if MANPATH is unset\n"
        printf "  ref: /etc/man.conf\n"
        return
    end

    if set -ql _flag_path
        command cat /etc/paths /etc/paths.d/*
        return
    end

    if set -ql _flag_manpath
        command cat /etc/manpaths
        printf "/usr/X11/man\n/Library/Apple/usr/share/man\n"
        command cat /etc/manpaths.d/*
        return
    end

    if test (count $argv) -eq $allargs # compare all arguments before parsing flags
        function __color_header
            set_color black -b white -o
            printf " $argv "
            set_color normal
            echo
        end

        __color_header PATH:

        __color_header /etc/paths

        command cat /etc/paths

        __color_header "/etc/paths.d/*"
        command cat /etc/paths.d/*

        echo

        __color_header MANPATH:

        __color_header /etc/manpaths
        command cat /etc/manpaths

        __color_header Default Additions
        printf "/usr/X11/man\n/Library/Apple/usr/share/man\n"

        __color_header "/etc/manpaths.d/*"
        command cat /etc/manpaths.d/*

        return
    end

end
