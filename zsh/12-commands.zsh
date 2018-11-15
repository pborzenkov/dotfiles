if (( $+commands[rg] )); then
	export RIPGREP_CONFIG_PATH=${HOME}/.ripgreprc
fi

# Use fd as fzf search engine
if (( $+commands[fd] )); then
	export FZF_DEFAULT_COMMAND='fd --type file'
	export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

if (( $+commands[jump] )); then eval "$(jump shell)"; fi
if (( $+commands[direnv] )); then eval "$(direnv hook zsh)"; fi

if (( $+commands[astream] )); then source <(astream --completion-script-bash); fi

for cmd in kubectl doctl helm; do
	if (( $+commands[$cmd] )); then add_lazy_completion $cmd; fi
done
