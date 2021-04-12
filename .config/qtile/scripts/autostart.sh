#!/bin/sh

lxpolkit &
nitrogen --restore &
picom &
xbindkeys &
dunst &
setxkbmap -model pc104 -layout us,us,es,de -option grp:alt_shift_toggle -variant ,dvorak
xss-lock xsecurelock &
xset r rate 220 30
xset s off
