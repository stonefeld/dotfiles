#!/bin/sh

function get_touchpad_id {
    xinput | grep "Elantech Touchpad" | cut -d "=" -f "2" | cut -d "[" -f "1"; return $?
}

t_id=$(get_touchpad_id)

function get_state {
    xinput list-props $t_id | grep "Device Enabled" | cut -d ":" -f "2"; return $?
}

t_state=$(get_state)

if [ $t_state -eq 1 ]; then
    xinput disable $t_id
else
    xinput enable $t_id
fi
