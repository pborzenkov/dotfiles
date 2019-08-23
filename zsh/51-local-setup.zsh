# fzf auto-completion
# ---------------
[[ -n "$FZF_COMPLETION" && $- == *i* ]] && source "${FZF_COMPLETION}" 2> /dev/null

# fzf key bindings
# ------------
[[ -n "$FZF_KEY_BINDINGS" ]] && source "${FZF_KEY_BINDINGS}"
