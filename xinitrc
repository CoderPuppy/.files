#!/bin/sh

systemctl --user --no-block start ssh-agent
source ~/.files/profilerc
#-xrandr-autoconfig &
xset dpms 0 0 900
[[ -e ~/.xmodmaprc && ! -d ~/.xmodmaprc ]] && xmodmap ~/.xmodmaprc
xset +fp /usr/share/fonts/local
xset fp rehash
# xrandr --newmode "1280x1024_66.00"  120.25  1280 1368 1496 1712 1024 1027 1034 1066 -hsync +vsync
# xrandr --addmode VGA1 1280x1024_66.00
[[ -e ~/.fehbg ]] && source ~/.fehbg
exec i3
# exec bspwm
