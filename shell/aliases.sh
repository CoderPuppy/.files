mcd() {
	mkdir -p $1
	cd $1
}

view() {
	pygmentize $1 | less -R
}

alias ls='ls --color'
alias l='less -R'
alias v=view
alias e="eval $EDITOR"
alias rehash='nodenv rehash; rbenv rehash; pyenv rehash; hash -rf'