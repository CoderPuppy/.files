fpath=(~/.zcompletion $fpath)

autoload -U compinit
compinit

zstyle ':completion:*' menu select=2
