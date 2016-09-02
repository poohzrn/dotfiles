#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import soco

def get_zones():
    """Return a list of Sonos Zones
    :returns: TODO

    """
    return list(soco.discover())

def mute_zones(zones):
    for zone in zones:
        zone.mute = True

def unmute_zones(zones):
    for zone in zones:
        zone.mute = False

def main():
    zones = get_zones()
    arg = str(sys.argv[-1])
    if arg == "mute":
        mute_zones(zones)
    elif arg == "unmute":
        unmute_zones(zones)
    else:
        pass

if __name__ == "__main__":
    main()
