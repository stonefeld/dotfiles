#!/bin/bash

if pgrep -x mpd
then
    ncmpcpp && killall mpd
else
    mpd && ncmpcpp && killall mpd
fi
