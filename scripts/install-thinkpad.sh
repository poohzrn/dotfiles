#!/bin/bash

#Installs ACPI events for Lenovo Thinkpad
#Requires root access in order to add the events to /etc/acpi/
sudo -v
sudo mkdir -p /etc/acpi/actions #Actions
sudo mkdir -p /etc/acpi/events #Events -> see acpi_listen & man acpid

#Actions and Events
EVENTS=(
    "thinkpad-dock"
    "thinkpad-undock"
    "thinkpad-lid-close"
    "thinkpad-lid-open")

ACTIONS=(
    "thinkpad-dock.sh"
    "thinkpad-undock.sh"
    "thinkpad-lid-close.sh"
    "thinkpad-lid-open.sh")

#Symlink events
for EVENT in "${EVENTS[@]}"
do
    if [ ! -e /etc/acpi/events/$EVENT ]; then
        sudo ln -sf ~/git/dotfiles/thinkpad/events/$EVENT /etc/acpi/events/$EVENT
    fi
done

#Symlink actions
for ACTION in "${ACTIONS[@]}"
do
    if [ ! -e /etc/acpi/actions/$ACTION ]; then
        sudo ln -sf ~/git/dotfiles/thinkpad/actions/$ACTION /etc/acpi/actions/$ACTION
    fi
done
