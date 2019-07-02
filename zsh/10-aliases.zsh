alias l="ls -G"
alias ll="ls -G -l"
alias la="ls -G -a"
alias sshfa='ssh -o ForwardAgent=yes'
alias sshvp='ssh -o ProxyCommand="nc -X connect -x acronis.sw.ru:80 %h %p"'

for c in find fd rg curl http open youtube-dl git;
	alias $c="noglob $c"

