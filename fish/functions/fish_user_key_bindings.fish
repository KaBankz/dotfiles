# If a script produces output, it should finish by calling
# `commandline -f repaint` to tell fish that a repaint is in order.
# ref: https://fishshell.com/docs/current/cmds/bind.html

# show random pokemon with ctrl + k
# the echo stops the name from being print in the prompt
# only bind if krabby is installed
type -q krabby && bind \ck "echo; krabby random; echo; commandline -f repaint"

# launch zoxide interactive mode with ctrl + f
# only bind if zoxide is installed
type -q zoxide && bind \cf "cdi; commandline -f repaint"
