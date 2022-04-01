autoload colors; colors

# The variables are wrapped in \%\{\%\}. This should be the case for every
# variable that does not contain space.
for COLOR in RED GREEN YELLOW BLUE MAGENTA CYAN BLACK WHITE; do
	export FG_$COLOR="$fg_no_bold[${(L)COLOR}]"
	export FG_BOLD_$COLOR="$fg_bold[${(L)COLOR}]"
	export BG_$COLOR="$bg_no_bold[${(L)COLOR}]"
	export BG_BOLD_$COLOR="$bg_bold[${(L)COLOR}]"
done

export RESET="$reset_color"
# export FG_RED FG_GREEN FG_YELLOW FG_BLUE FG_WHITE FG_BLACK
# export FG_BOLD_RED FG_BOLD_GREEN FG_BOLD_YELLOW FG_BOLD_BLUE
# export FG_BOLD_WHITE FG_BOLD_BLACK

# Clear LSCOLORS
# unset LS_COLORS

# Main change, you can see directories on a dark background
# export LS_COLORS=gxfxcxdxbxegedabagacad

# export CLICOLOR=1
# export LS_COLORS=exfxcxdxbxegedabagacad
