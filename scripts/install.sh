#!/usr/bin/env bash
#Create folders
mkdir -p ~/.olddotfiles #backup for old dots
mkdir -p ~/.olddotfiles/scripts/ #backup for old dots
mkdir -p ~/.olddotfiles/.i3/ #backup for old dots
mkdir -p ~/.vim/bundle #folder for vim plugins
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
PLUGINS=("https://github.com/hdima/python-syntax.git"
    "https://github.com/kien/ctrlp.vim"
    "https://github.com/bling/vim-airline"
    "https://github.com/kien/ctrlp.vim"
    "https://github.com/tpope/vim-fugitive"
    "https://github.com/Valloric/YouCompleteMe"
    "https://github.com/tomasr/molokai"
    "https://github.com/LaTeX-Box-Team/LaTeX-Box"
    "https://github.com/honza/vim-snippets"
    "https://github.com/SirVer/ultisnips"
    "https://github.com/ervandew/supertab"
    "https://github.com/majutsushi/tagbar"
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

# Install Pathogen
if [ ! -e ~/.vim/autoload/pathogen.vim ]; then
    echo "installing pathogen.."
    mkdir ~/.vim/autoload
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
fi

#VIM plugins - Update / install
for P in "${PLUGINS[@]}"
do
    PLUGINNAME=${P##https://github.com/*/}
    PLUGINNAME=${PLUGINNAME%.git} #remove .git 
    if [ -e ~/.vim/bundle/$PLUGINNAME/ ]; then
        echo "Updating $PLUGINNAME addon.." 
        cd ~/.vim/bundle/$PLUGINNAME && git pull
        if [ $PLUGINNAME = "YouCompleteMe" ]; then
            git submodule update --recursive
        fi
    else
        echo "Installing $PLUGINNAME addon.." 
        cd ~/.vim/bundle/ && git clone $P
        if [ $PLUGINNAME = "YouCompleteMe" ]; then
            cd ~/.vim/bundle/$PLUGINNAME && git pull && git submodule update --init --recursive && python install.py
        fi
    fi
done
# Reload dotfiles
. ~/.bashrc
