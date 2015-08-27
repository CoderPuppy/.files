mcd() {
	mkdir -p $1
	cd $1
}

view() {
	pygmentize $1 | less -R
}

fe() {
	local file="`find -type f -name \*$*\*`"
	echo $file
	# expr length "$file"
	if [ $(expr length "$file") = 0 ]; then
		echo "No file found"
	else
		echo "$file" | xargs $EDITOR
	fi
}

alias ls='ls --color'
alias l='less -R'
alias v=view
alias e='eval $EDITOR'
alias rehash='rbenv rehash; pyenv rehash; luaenv rehash; hash -rf'
alias :q=exit
alias :Q=exit
alias dmenu='dmenu -i -sf \#af865a -sb \#4A3637 -nf \#c0b18b -nb \#1f1f1f'
alias gh=hub
