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

e() {
	$EDITOR "$@"
}

alias ls='ls --color'
alias l='less -R'
alias v=view
alias rehash='rbenv rehash; pyenv rehash; luaenv rehash; nodenv rehash; hash -rf'
alias :q=exit
alias :Q=exit
export dmenu_colors='-sf \#af865a -sb \#4A3637 -nf \#c0b18b -nb \#1f1f1f'
export dmenu_opts="-i"
alias dmenu="dmenu $dmenu_colors $dmenu_opts"
alias gh=hub
alias enscript-f1="enscript -fTimes-Roman12 -b '\$D{%Y-%m-%d %H:%M:%S %z}|%H|(\$%/\$=)' --word-wrap --mark-wrapped-lines=arrow -MLetter"
