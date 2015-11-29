#!/bin/bash

PRIMARY="LVDS1"
EXTDISPLAYS=("VGA1" "HDMI1" "HDMI2" "HDMI3")


for EXTDISPLAY in "${EXTDISPLAYS[@]}"
do
    if (xrandr | grep "$EXTDISPLAY disconnected");
    then
        xrandr --output $PRIMARY --auto --output $EXTDISPLAY --off
    else
        xrandr --output $PRIMARY --auto --primary --output $EXTDISPLAY --auto --right-of $PRIMARY
    fi
done
