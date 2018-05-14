# Dedup all paths
typeset -U fpath
typeset -U path
typeset -U manpath
typeset -U INFOPATH

# Prefer binaries from home
path=(${HOME}/bin $path)

# Make sure our local functions are accessible
fpath=(${HOME}/.zsh/functions $fpath)
