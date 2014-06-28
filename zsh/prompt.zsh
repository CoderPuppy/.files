export DEFAULT_USER=cpup

parse_git_dirty() {
	local SUBMODULE_SYNTAX=''
	local GIT_STATUS=''
	local CLEAN_MESSAGE='nothing to commit (working directory clean)'
	if [[ "$(command git config --get oh-my-zsh.hide-status)" != "1" ]]; then
		if [[ $POST_1_7_2_GIT -gt 0 ]]; then
			SUBMODULE_SYNTAX="--ignore-submodules=dirty"
		fi
		if [[ "$DISABLE_UNTRACKED_FILES_DIRTY" == "true" ]]; then
			GIT_STATUS=$(command git status -s ${SUBMODULE_SYNTAX} -uno 2> /dev/null | tail -n1)
		else
			GIT_STATUS=$(command git status -s ${SUBMODULE_SYNTAX} 2> /dev/null | tail -n1)
		fi
		if [[ -n $GIT_STATUS ]]; then
			echo "$ZSH_THEME_GIT_PROMPT_DIRTY"
		else
			echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
		fi
	else
		echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
	fi
}

function prompt() {
	local prompt_name=$1
	local prompts_path=~/.files/zsh/prompts
	local prompt_path=$prompts_path/$1.zsh
	if [[ -n $prompt_name && -f $prompt_path ]]; then
		source $prompt_path
	else
		echo "Available prompts: "
		ls ~/.files/zsh/prompts | sed s/\\.zsh//
	fi
}

# themes = agnoster, minimal
prompt minimal