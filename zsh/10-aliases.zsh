alias l="ls -G"
alias ll="ls -G -l"
alias la="ls -G -a"
alias sshfa='ssh -o ForwardAgent=yes'

for c in find fd rg curl http open youtube-dl git;
	alias $c="noglob $c"

if (( $+commands[nvim] )); then
	alias vim=nvim
	export EDITOR=nvim
	export GIT_EDITOR=nvim
fi
