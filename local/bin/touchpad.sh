#!/bin/sh

id=$(xinput list | grep Synaptics | grep -o 'id=[0-9]*' | cut -d'=' -f2)
state=$(xinput list-props 13 | grep "libinput Tapping Enabled (" | cut -d':' -f2)
if [ -n "$1" ]
then
    xinput set-prop 13 "libinput Tapping Enabled" 1
else    
    if [ $state -eq 0 ]
    then 
    	xinput set-prop 13 "libinput Tapping Enabled" 1
    else
    	xinput set-prop 13 "libinput Tapping Enabled" 0
    fi
fi
