#!/bin/sh

source ~/.files/profilerc
-xrandr-autoconfig &
[[ -e ~/.xmodmaprc && ! -d ~/.xmodmaprc ]] && xmodmap ~/.xmodmaprc
#exec i3
xset +fp /usr/share/fonts/local
xset fp rehash
SXHKD_SHELL=bash sxhkd &
exec bspwm
