#!/bin/sh

lxpolkit &
nitrogen --restore &
picom &
xbindkeys -f $XDG_CONFIG_HOME/xbindkeys/config_qtile &
dunst -config $XDG_CONFIG_HOME/dunst/dunstrc_qtile_light &
setxkbmap -model pc104 -layout us,es,de -option grp:alt_shift_toggle
xss-lock xsecurelock &
xset r rate 220 30
xset s off
touchscreen
