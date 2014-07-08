# Git: branch/detached head, dirty status
prompt_git() {
	local ref dirty
	if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
		ZSH_THEME_GIT_PROMPT_DIRTY='±'
		dirty=$(parse_git_dirty)
		ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="➦ $(git show-ref --head -s --abbrev |head -n1 2> /dev/null)"
		if [[ -n $dirty ]]; then
			prompt_segment yellow black
		else
			prompt_segment green black
		fi
		echo -n "${ref/refs\/heads\// }$dirty"
	fi
}

nowidth() {
	echo -n '%{'$@'%}'
}

spacer() {
	# local SPACER_COLOR=
	local SPACER_COLOR=$FG_BOLD_BLACK

	nowidth $SPACER_COLOR
	echo -n $@
	nowidth $RESET
}

# symbols = λ❮❯⏎✚✹✖➜═✭
# was successful     = [[ $RETVAL -eq 0 ]]
# wasn't successful  = [[ $RETVAL -ne 0 ]]
# is root            = [[ $UID -eq 0 ]]
# has jobs           = [[ $(jobs -l | wc -l) -gt 0 ]]

left_prompt() {
	RETVAL=$?

	# local DIR_COLOR=
	local DIR_COLOR=$FG_BOLD_WHITE

	echo -n ' '

	nowidth $DIR_COLOR
	# current directory
	echo -n '%1~'
	nowidth $RESET

	if [[ $UID -eq 0 ]]; then
		spacer ' ~'
	else
		spacer ' -'
	fi

	echo -n ' '
}

right_prompt() {
	RETVAL=$?

	# local ERROR_COLOR=
	# local ERROR_COLOR=$FG_RED
	local ERROR_COLOR=$FG_BOLD_RED

	# local JOBS_COLOR=
	local JOBS_COLOR=$FG_BOLD_BLACK

	# local TIME_COLOR=
	local TIME_COLOR=$FG_BOLD_BLACK

	if [[ $RETVAL -ne 0 ]]; then
		nowidth $ERROR_COLOR
		echo -n '!'
		nowidth $RESET
	fi

	spacer '[ '

	if [[ $(jobs -l | wc -l) -gt 0 ]]; then
		nowidth $JOBS_COLOR
		echo -n $(jobs -l | wc -l)
		nowidth $RESET

		spacer ' : '
	fi

	nowidth $TIME_COLOR
	echo -n '%*'
	nowidth $RESET

	spacer ' ]'
}
 
PROMPT='%{%f%b%k%}$(left_prompt)'
RPROMPT='%{%f%b%k%}$(right_prompt)'