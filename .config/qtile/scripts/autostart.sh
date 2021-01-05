#!/bin/sh

polkit-dumb-agent &
nitrogen --restore &
picom &
xbindkeys &
dunst &
setxkbmap -model pc104 -layout us,es,de -option grp:alt_shift_toggle
light-locker &
xset s off
