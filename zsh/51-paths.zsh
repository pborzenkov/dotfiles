# If we have homebrew/linuxbrew installed, make sure
# we include its paths as well
if (( $+commands[brew] )); then
	local p="$(brew --prefix)"

	fpath=("${p}"/share/zsh/site-functions $fpath)
	path=("${p}"/bin "${p}"/sbin $path)
	manpath=("${p}"/share/man $manpath)
	INFOPATH="${p}/share/info:$INFOPATH"
fi
