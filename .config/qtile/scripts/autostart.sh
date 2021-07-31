#!/bin/sh

lxpolkit &
nitrogen --restore &
picom &
xbindkeys -f "${XDG_CONFIG_HOME:-$HOME/.config}"/xbindkeys/config &
dunst &
xss-lock slock &
xset r rate 220 30
xset s off
touchscreen
