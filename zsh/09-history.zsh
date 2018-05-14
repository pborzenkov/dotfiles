# append to history file to support multiple parallel zsh sessions
setopt append_history

# save timestamp and duration to history
setopt extended_history

# ignore duplicates in history
setopt hist_ignore_all_dups

# ignore commands with leading space char
setopt hist_ignore_space

# remove superfluous blanks before adding to history
setopt hist_reduce_blanks

# share history with other sessions
setopt share_history

HISTFILE=${HOME}/.zsh/history
HISTSIZE=1024
SAVEHIST=1024
