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
	compdef _kubectl_load_completion kubectl

	kubectl() {
		_kubectl_load_completion
		$0 "$@"
	}

	_kubectl_load_completion() {
		unfunction kubectl
		unfunction _kubectl_load_completion
		compdef -d kubectl

		source <(kubectl completion zsh)
	}
fi

# Lazy load doctl completions
if (( $+commands[doctl] )); then
	compdef _doctl_load_completion doctl

	doctl() {
		_doctl_load_completion
		$0 "$@"
	}

	_doctl_load_completion() {
		unfunction doctl
		unfunction _doctl_load_completion
		compdef -d doctl

		source <(doctl completion zsh)
	}
fi
