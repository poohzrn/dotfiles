#!/bin/bash

DELL_U2515H_1='dev:/dev/i2c-7'
DELL_U2515H_2='dev:/dev/i2c-8'
INPUT_SOURCE_CONTROL='0x60'
INPUT_SOURCE_DP=15
INPUT_SOURCE_mDP=16
INPUT_SOURCE_HDMI_1=17
INPUT_SOURCE_HDMI_2=18
ALL_MON="TRUE"

while [ $# -gt 0 ]
do
    key="$1"
    case $key in
        -t| --toggle)
        TOGGLE=1
        shift;;
        -l| --left)
        MONITOR=$DELL_U2515H_2
        ALL_MON="FALSE"
        shift;;
        -r| --right)
        MONITOR=$DELL_U2515H_1
        ALL_MON="FALSE"
        shift;;
        -mdp| --mini-displayport| -linux)
        INPUT_SOURCE=$INPUT_SOURCE_mDP;;
        -dp| --displayport| -mac)
        INPUT_SOURCE=$INPUT_SOURCE_DP;;
        -hdmi1| --hdmi-1)
        INPUT_SOURCE=$INPUT_SOURCE_HDMI_1;;
        -hdmi2| --hdmi-2| -win)
        INPUT_SOURCE=$INPUT_SOURCE_HDMI_2;;
    esac
    shift
done

if [[ "$ALL_MON" == 'TRUE' && ! -z $INPUT_SOURCE ]]; then
    echo "Changing iputsource for all monitors"
    ddccontrol -r $INPUT_SOURCE_CONTROL -w $INPUT_SOURCE $DELL_U2515H_1 >> /dev/null
    ddccontrol -r $INPUT_SOURCE_CONTROL -w $INPUT_SOURCE $DELL_U2515H_2 >> /dev/null
elif [[ ! -z $INPUT_SOURCE ]]; then
        ddccontrol -r $INPUT_SOURCE_CONTROL -w $INPUT_SOURCE $MONITOR >> /dev/null
else
    echo "options: [-l --left | -r --right] input [-mdp|-dp|-hdmi1|hdmi2]"
fi
