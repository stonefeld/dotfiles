#!/bin/bash

if pgrep -x mpd
then
    ncmpcpp
else
    mpd && ncmpcpp
fi
