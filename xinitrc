#!/bin/sh

source ~/.files/profilerc
-xrandr-autoconfig &
[[ -e ~/.xmodmaprc && ! -d ~/.xmodmaprc ]] && xmodmap ~/.xmodmaprc
exec i3