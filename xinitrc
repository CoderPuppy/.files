#!/bin/sh

source ~/.files/profilerc
#-xrandr-autoconfig &
xset dpms 0 0 900
[[ -e ~/.xmodmaprc && ! -d ~/.xmodmaprc ]] && xmodmap ~/.xmodmaprc
xset +fp /usr/share/fonts/local
xset fp rehash
exec i3
# exec bspwm
