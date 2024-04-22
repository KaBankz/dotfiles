# load homebrew
# this is up at the top to make sure it's loaded before anything else
# as homebrew manages the majority of the used binaries

# hardcoding homebrew env and path to avoid running `brew shellenv` because
# they do not properly add to the PATH variable causing duplicated
# entries in nested shells and other issues (duplicated MANPATH and INFOPATH)
set -gx HOMEBREW_PREFIX /opt/homebrew
set -gx HOMEBREW_CELLAR /opt/homebrew/Cellar
set -gx HOMEBREW_REPOSITORY /opt/homebrew
set -gx MANPATH /opt/homebrew/share/man
set -gx INFOPATH /opt/homebrew/share/info

fish_add_path -P /opt/homebrew/bin /opt/homebrew/sbin
