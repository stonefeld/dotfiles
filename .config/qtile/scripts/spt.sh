#!/bin/bash

if pgrep -x spotifyd
then
    spt && killall spotifyd
else
    spotifyd && spt && killall spotifyd
fi
