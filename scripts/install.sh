#!/usr/bin/env bash
#Create folders
mkdir -p ~/.olddotfiles #backup for old dots
mkdir -p ~/.olddotfiles/scripts/ #backup for old dots
mkdir -p ~/.olddotfiles/.i3/ #backup for old dots
mkdir -p ~/.i3/ #folder for i3 config 
mkdir -p ~/scripts/ #folder for different scripts

DOTFILES=(".bash_aliases"
    ".bashrc"
    ".bash_prompt"
    ".vimrc"
    ".profile" 
    ".slate" 
    ".tmux.conf"
    ".Xresources"
    ".i3/config"
    ".i3/i3status.conf"
    ".xsessionrc"
    "scripts/lock.sh"
    "scripts/servermgmt.sh"
)
#create backup and symlinks to dotfiles
for file in "${DOTFILES[@]}"
do
    if [ -e ~/$file ]; then
        mv ~/$file ~/.olddotfiles/$file
    fi
    ln -s ~/git/dotfiles/$file ~/$file
done

#Install Mac aliases if OSX
case $OSTYPE in darwin*)
    ln -s ~/git/dotfiles/.bash_aliases_mac ~/.bash_aliases_mac
    ;; esac

# Reload dotfiles
. ~/.bashrc
