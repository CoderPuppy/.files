fpath=(~/.zcompletion ~/.files/zsh/zsh-completions/src $fpath)

autoload -U compinit
compinit

zstyle ':completion:*' menu select=2
zstyle ":completion:*:descriptions" format "%B%d%b"

# source ~/.files/zsh/completion/tmuxinator.zsh
