#!/bin/sh

lxpolkit &
nitrogen --restore &
picom &
xbindkeys -f "$XDG_CONFIG_HOME"/xbindkeys/config &
dunst &
setxkbmap us
xss-lock xsecurelock &
xset r rate 220 30
xset s off
touchscreen
