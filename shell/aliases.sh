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

suspend() {
	systemctl suspend
	if which lock > /dev/null 2>&1; then
		lock
	fi
}

hibernate() {
	systemctl hibernate
	if which lock > /dev/null 2>&1; then
		lock
	fi
}

alias ls='ls --color'
alias l='less -R'
alias v=view
alias e='eval $EDITOR'
alias rehash='nodenv rehash; rbenv rehash; pyenv rehash; luaenv rehash; hash -rf'
alias :q=exit