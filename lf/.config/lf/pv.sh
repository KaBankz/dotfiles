#!/bin/sh

# Force bat to use interpolated 8-bit colors
unset COLORTERM
# -p/--plain renders plain unstyled text
# -n/--number renders line numbers
# --color=always renders colors
bat --plain --number --color=always --theme=Dracula "$1"
