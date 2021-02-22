#!/bin/sh

function get_touchpad_id {
    xinput | grep "Elantech Touchpad" | cut -d "=" -f "2" | cut -d "[" -f "1"; return $?
}

t_id=$(get_touchpad_id)

function get_state {
    xinput list-props $t_id | grep "Device Enabled" | cut -d ":" -f "2"; return $?
}

t_state=$(get_state)
messageID="12121212"
appName="touchpad.sh"

if [ $t_state -eq 1 ]; then
    xinput disable $t_id
    dunstify -a $appName -i touchpad-indicator-light-disabled -r $messageID "Touchpad Disabled" "Press Shift + F6 to enable it"
    canberra-gtk-play -i dialog-warning
else
    xinput enable $t_id
    dunstify -a $appName -i touchpad-indicator-light-enabled -r $messageID "Touchpad Enabled" "Press Shift + F6 to disable it"
    canberra-gtk-play -i dialog-warning
fi
