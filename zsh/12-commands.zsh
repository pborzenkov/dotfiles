# Use tag wrapper around rg
if (( $+commands[tag] )); then
	export TAG_SEARCH_PROG=rg
	tag() { command tag "$@"; source ${TAG_ALIAS_FILE:-/tmp/tag_aliases} 2>/dev/null }
	alias rg='noglob tag'
fi

# Use fd as fzf search engine
if (( $+commands[fd] )); then
	export FZF_DEFAULT_COMMAND='fd --type file'
	export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

if (( $+commands[jump] )); then eval "$(jump shell)"; fi
if (( $+commands[direnv] )); then eval "$(direnv hook zsh)"; fi

# Lazy load kubectl completions
if (( $+commands[kubectl] )); then
	kubectl() {
		unfunction "$0"
		source <(kubectl completion zsh)
		$0 "$@"
	}
fi


