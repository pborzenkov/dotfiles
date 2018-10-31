# Use vi-mode
bindkey -v
# But add some useful emacs-mode bindings
bindkey '^a' beginning-of-line
bindkey '^b' push-line-or-edit
bindkey '^e' end-of-line
bindkey '^l' clear-screen
bindkey '^k' kill-line
bindkey '^u' backward-kill-line
bindkey '^p' history-search-backward
bindkey '^n' insert-last-word
bindkey '^?' backward-delete-char

# Reduce <ESC> key timeout to 0.1 second
export KEYTIMEOUT=1

# Don't count / as word separator
export WORDCHARS=${WORDCHARS/\//}

setopt noflowcontrol
stty stop undef
stty start undef
stty -ixon -ixoff
