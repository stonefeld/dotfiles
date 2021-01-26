#!/bin/sh

cat <<EOF | xmenu | sh &
Utilities
	Firefox	firefox
	GIMP	gimp
Settings
	Pulseaudio Volume Control		pavucontrol
	Lxappearance					lxappearance

Power		~/.config/rofi/scripts/launch.sh powermenu
EOF
