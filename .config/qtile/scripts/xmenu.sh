#!/bin/sh

cat <<EOF | xmenu | sh &
Utilities
	Web Browser		firefox
	Image editor	gimp
Settings
	Pulseaudio Volume Control		pavucontrol
	Lxappearance					lxappearance

Power		~/.config/rofi/scripts/launch.sh powermenu
EOF
