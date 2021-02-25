#!/bin/sh

lxpolkit &
nitrogen --restore &
picom &
xbindkeys &
dunst &
setxkbmap -model pc104 -layout us,es,de -option grp:alt_shift_toggle
xss-lock xsecurelock &
xset s off
$HOME/.config/qtile/scripts/touchscreen.sh
