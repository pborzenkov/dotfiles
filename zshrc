for file in $HOME/.zsh/*.zsh; do
	source "$file"
done


export EDITOR="vim"

export FZF_DEFAULT_COMMAND='fd --type file'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export RIPGREP_CONFIG_PATH=${HOME}/.ripgreprc
