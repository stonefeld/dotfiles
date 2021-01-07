#!/bin/bash

cache_file=$HOME/.config/scripts/updates
if [ ! -f $cache_file ]; then
    touch $cache_file
    echo 0 > $cache_file
fi

function read_cache_file {
    cat $cache_file
}

function update_count {
    checkupdates | wc -l; return $?
}

function notify {
    if [ $# -eq 2 ]; then
        dunstify -a $appName -i cloud-download -r $messageID "Package Upgrade" "$2 new upgrades available ($1 from last time)"
        canberra-gtk-play -i dialog-warning
    else
        dunstify -a $appName -i cloud-download -r $messageID "Package Upgrade" "There are $1 packages to upgrade"
        canberra-gtk-play -i dialog-warning
    fi
}

last_count=$(read_cache_file)
last_available=false
if [ $last_count -ne 0 ]; then
    last_available=true
fi

count=$(update_count)
messageID="69696969"
appName="pacman"

dunstify -a $appName -i cloud-download -r $messageID "Package Upgrade" "Checking for any package to upgrade"
canberra-gtk-play -i dialog-warning

sleep 2

if [ $count -gt 0 ]; then
    if [ $last_available == true ]; then
        if [ $last_count -lt $count ]; then
            notify $count $((count-last_count))
            echo $count > $cache_file
        else
            notify $count
            echo $count > $cache_file
        fi
    else
        notify $count
        echo $count > $cache_file
    fi
else
    dunstify -a $appName -i cloud-download -r $messageID "Package Upgrade" "There are no packages to upgrade"
    canberra-gtk-play -i dialog-warning
    echo 0 > $cache_file
fi
