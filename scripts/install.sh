#!/usr/bin/env bash
#Create folders
mkdir -p ~/.i3/ #folder for i3 config 
mkdir -p ~/scripts/ #folder for different scripts
mkdir -p ~/.config/fish/

BASHFILES=("bash_aliases" "bashrc" "bash_prompt")
SCRIPTS=("lock.sh" "servermgmt.sh")
MUSTHAVES=("vimrc" "tmux.conf")
function INSTALLDOTS {
    for file in "${DOTS[@]}"
    do
        ln -sf ~/git/dotfiles/dots/$file ~/.$file
    done
}
arr=( $(find  -type f) )

if [[ -z $1 ]]; then
    echo "usage: ./install (all|X|fish|bash)"
    exit
fi
if [[ $1 == "all" ]]; then
    DOTS=($(find ~/git/dotfiles/dots/* -type f -printf "%f\n"))
    ln -sf ~/git/dotfiles/fish/config.fish ~/.config/fish/
fi
if [[ $1 == "X" ]]; then
    DOTS=("Xresources" "i3/config" "i3/i3status.conf")
fi
if [[ $1 == "fish" ]]; then
    ln -sf ~/git/dotfiles/fish/config.fish ~/.config/fish/
    exit 0
fi
if [[ $1 == "bash" ]]; then
    DOTS=($(find ~/git/dotfiles/dots/bash* -type f -printf "%f\n"))
fi
INSTALLDOTS


#Install Mac aliases if OSX
case $OSTYPE in darwin*)
    ln -sf ~/git/dotfiles/.bash_aliases_mac ~/.bash_aliases_mac
    ln -sf ~/git/dotfiles/.slate ~/.slate
    ;; esac

#install fish
#ln -sf ~/git/dotfiles/fish/config.fish ~/.config/fish/
