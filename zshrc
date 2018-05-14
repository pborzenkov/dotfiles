for file in $HOME/.zsh/*.zsh; do
	source "$file"
done

# avoid beeping
setopt nobeep

PROMPT="%B%m%b %j %20<...<%~%# "

function zle-line-init zle-keymap-select {
	VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]%  %{$reset_color%}"
	RPROMPT="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $ERPROMPT"
	zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

export WORDCHARS=${WORDCHARS/\//}

setopt extendedglob
setopt noclobber

## Background options
setopt notify
## ENDIF Background options

CLICOLOR=1
alias l="ls"
alias ll="ls -l"
alias la="ls -a"
alias gd='godoc $(gopkgs | fzf) | less'
alias sshfa='ssh -o ForwardAgent=yes'
alias sshvp='ssh -o ProxyCommand="nc -X connect -x acronis.sw.ru:80 %h %p"'

export EDITOR="vim"

for c in find fd rg curl http;
	alias $c="noglob $c"

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

if (( $+commands[brew] )); then
	local p="$(brew --prefix)"

	fpath=("${p}"/share/zsh/site-functions $fpath)
	path=("${p}"/bin "${p}"/sbin $path)
	manpath=("${p}"/share/man $manpath)
	INFOPATH="${p}/share/info:$INFOPATH"
fi
