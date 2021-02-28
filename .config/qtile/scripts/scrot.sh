#!/bin/sh

if [[ $# -eq 1 ]]; then
    scrot -d $1 $HOME/Pictures/screenshots/screenshot_%Y_%m_%d_%H_%M_%S.png
    canberra-gtk-play -i device-added
else
    scrot $HOME/Pictures/screenshots/screenshot_%Y_%m_%d_%H_%M_%S.png
    canberra-gtk-play -i device-added
fi
