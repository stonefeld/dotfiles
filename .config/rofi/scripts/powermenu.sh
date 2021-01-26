#!/bin/bash

if [ -z "$@" ]; then
    echo -en "Shutdown\0icon\x1fsystem-shutdown\n"
    echo -en "Suspend\0icon\x1fsystem-suspend\n"
    echo -en "Reboot\0icon\x1fsystem-restart\n"
    echo -en "Logout\0icon\x1fsystem-log-out\n"
else
    if [ "$1" = "Shutdown" ]; then
        shutdown now
    elif [ "$1" = "Suspend" ]; then
        systemctl suspend
    elif [ "$1" = "Reboot" ]; then
        reboot
    elif [ "$1" = "Logout" ]; then
        qtile-cmd -o cmd -f shutdown
    fi
fi
