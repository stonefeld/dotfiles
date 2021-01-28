#!/bin/sh

function get_touchpad_id {
    xinput | grep "Elantech Touchpad" | cut -d "=" -f "2" | cut -d "[" -f "1"; return $?
}

t_id=$(get_touchpad_id)
echo $t_id

function get_state {
    xinput list-props $t_id | grep "Device Enabled" | cut -d ":" -f "2"; return $?
}

t_state=$(get_state)
echo $t_state

if [ $t_state -eq 1 ]; then
    echo noise
    xinput disable $t_id
else
    echo noisent
    xinput enable $t_id
fi
