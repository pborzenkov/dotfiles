for file in $HOME/.zsh/*.zsh; do
	source "$file"
done

# avoid beeping
setopt nobeep

setopt extendedglob
setopt noclobber

## Background options
setopt notify
## ENDIF Background options


export EDITOR="vim"

if (( $+commands[tag] )); then
	export TAG_SEARCH_PROG=rg
	tag() { command tag "$@"; source ${TAG_ALIAS_FILE:-/tmp/tag_aliases} 2>/dev/null }
	alias rg='noglob tag'
fi
if (( $+commands[jump] )); then eval "$(jump shell)"; fi
if (( $+commands[direnv] )); then eval "$(direnv hook zsh)"; fi
if (( $+commands[kubectl] )); then source <(kubectl completion zsh); fi

export FZF_DEFAULT_COMMAND='fd --type file'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export RIPGREP_CONFIG_PATH=${HOME}/.ripgreprc
