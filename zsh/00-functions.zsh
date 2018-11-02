add_lazy_completion() {
	local cmd="$1"

	eval "
	compdef _${cmd}_load_completion ${cmd}

	${cmd}() {
		_${cmd}_load_completion
		"\$0" "\$@"
	}

	_${cmd}_load_completion() {
		unfunction ${cmd}
		unfunction _${cmd}_load_completion
		compdef -d ${cmd}

		source <(${cmd} completion zsh)
	}
	"
}
