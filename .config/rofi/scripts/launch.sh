#!/bin/bash

menu="$1"

if [ "$menu" = "drun" ]; then
    rofi -show drun -theme applauncher
elif [ "$menu" = "powermenu" ]; then
    rofi -modi 'Powermenu:~/.config/rofi/scripts/powermenu.sh' -show Powermenu -theme powermenu
fi
