#!/bin/bash

if pgrep -x spotifyd
then
    spt
else
    spotifyd && spt
fi
