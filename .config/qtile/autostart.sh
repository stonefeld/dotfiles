#!/bin/sh

nitrogen --restore &
picom --experimental-backends &
xbindkeys &
dunst &
setxkbmap -model pc105 -layout us,es,de -option grp:alt_shift_toggle
light-locker &
