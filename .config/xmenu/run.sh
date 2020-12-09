#!/bin/sh

cat <<EOF | xmenu | sh &
Utilities
	Web Browser		firefox
	Image editor	gimp
Games
	Dwarf Fortress				dwarffortress
	Cataclysm Dark Days Ahead	cataclysm-tiles
Settings
	Pulseaudio Volume Control		pavucontrol
	Lxappearance					lxappearance

Power		/home/master/.config/rofi/scripts/launch.sh powermenu
EOF
