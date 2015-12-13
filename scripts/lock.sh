#!/bin/bash
scrot /tmp/screen.png
convert /tmp/screen.png -blur 25 -blur 25 /tmp/screen.png
dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Stop
i3lock -u -i /tmp/screen.png
rm /tmp/screen.png
