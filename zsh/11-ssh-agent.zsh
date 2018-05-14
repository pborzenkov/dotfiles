# On local host use gpg-agent, on remote host use forwarded agent socket
if [ -z "${SSH_CONNECTION}" ]; then
	export GPG_TTY=$(tty)
	export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
	gpgconf --launch gpg-agent
fi
