#!/bin/bash

# Force bat to use interpolated 8-bit colors
unset COLORTERM
# -p/--plain renders plain unstyled text
# -n/--number renders line numbers
# --color=always renders colors
# --terminal-width shrink the size of bat output to fit lf preview
bat --plain --number --color=always --theme=Dracula --terminal-width $(($2-4)) "$1"
