#!/usr/bin/env bash
#Ensure we have a pool
mkdir -p ~/.config/fish/functions
WATER=~/.config/fish/functions
SWIMMERS=~/git/dotfiles/fish/*.fish
for FISH in $SWIMMERS
do
    #Old fish smells (-f)
    ln -sf $FISH $WATER/
done
