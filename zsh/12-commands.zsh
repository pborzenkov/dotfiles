if (( $+commands[tag] )); then
	export TAG_SEARCH_PROG=rg
	tag() { command tag "$@"; source ${TAG_ALIAS_FILE:-/tmp/tag_aliases} 2>/dev/null }
	alias rg='noglob tag'
fi
if (( $+commands[jump] )); then eval "$(jump shell)"; fi
if (( $+commands[direnv] )); then eval "$(direnv hook zsh)"; fi
if (( $+commands[kubectl] )); then
	kubectl() {
		unfunction "$0"
		source <(kubectl completion zsh)
		$0 "$@"
	}
fi


