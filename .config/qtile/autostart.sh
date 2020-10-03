#!/bin/sh

nitrogen --restore &
picom --experimental-backends &
xbindkeys &
setxkbmap -model pc105 -layout us,es,de -option grp:alt_shift_toggle
/usr/lib/xfce4/notifyd/xfce4-notifyd &
light-locker &
