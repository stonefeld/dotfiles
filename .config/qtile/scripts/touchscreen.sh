#!/bin/sh

function get_touchscreen_id {
    xinput | grep "ELAN Touchscreen" | cut -d "=" -f "2" | cut -d "[" -f "1"; return $?
}

t_id=$(get_touchscreen_id)
xinput disable $t_id
