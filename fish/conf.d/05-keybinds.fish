# launch fzf with ctrl + f
# only bind if fzf is installed
type -q fzf && bind \cf fzf

# show random pokemon with ctrl + k
# the echo stops the name from being print in the prompt
# the commandline -f repaint, repaints the prompt after executing the krabby command
# only bind if krabby is installed
type -q krabby && bind \ck "echo; krabby random; echo; commandline -f repaint"
