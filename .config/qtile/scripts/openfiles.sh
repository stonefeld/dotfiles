#!/bin/sh

if [[ $1 -eq 1 ]]; then
    nm-applet &
elif [[ $1 -eq 2 ]]; then
    killall nm-applet
elif [[ $1 -eq 3 ]]; then
    alacritty -e htop &
elif [[ $1 -eq 4 ]]; then
    killall htop
fi
