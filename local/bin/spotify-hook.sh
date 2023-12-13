#!/bin/sh
status=$(playerctl -p playerctld status)
if [ "$status" = "Playing" ]; then
    echo "󰏤 " 
else
    echo " "
fi
