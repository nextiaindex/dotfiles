ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
	mkdir -p "$(dirname $ZINIT_HOME)"
	git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

zinit ice depth=1;
zinit light nextiaindex/zsh-vi-mode
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-syntax-highlighting

PROMPT="%K{black} %k%K{black}%F{cyan}%~%f%k%K{black} %k %K{black} %k%K{black}%F{yellow}$%f%k%K{black} %k "

alias ls='ls --color'

export PATH="${HOME}/.local/bin/:$PATH"

export EDITOR=nvim

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
autoload -Uz compinit && compinit
