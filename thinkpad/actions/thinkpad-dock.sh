#!/bin/sh
xrandr --output LVDS1 --off --output VGA1 --auto --primary
xrandr --output HDMI3 --auto --left-of VGA1
feh --bg-fill ~/.wallpaper.jpg
