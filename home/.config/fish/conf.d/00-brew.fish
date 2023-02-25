# load homebrew
# this is up at the top to make sure it's loaded before anything else
# as homebrew manages the majority of the used binaries
# this also only runs if not in a nested shell to avoid duplicated PATH
if test "$SHLVL" -eq 1
    eval (/opt/homebrew/bin/brew shellenv)
end

# TODO: insead of running this script, just hardcode the paths manually
# below is the output of `brew shellenv`
# set -gx HOMEBREW_PREFIX /opt/homebrew
# set -gx HOMEBREW_CELLAR /opt/homebrew/Cellar
# set -gx HOMEBREW_REPOSITORY /opt/homebrew
# set -q PATH; or set PATH ''
# set -gx PATH /opt/homebrew/bin /opt/homebrew/sbin $PATH
# set -q MANPATH; or set MANPATH ''
# set -gx MANPATH /opt/homebrew/share/man $MANPATH
# set -q INFOPATH; or set INFOPATH ''
# set -gx INFOPATH /opt/homebrew/share/info $INFOPATH
