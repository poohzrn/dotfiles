#!/usr/bin/env bash
DOTFILES=(".bash_aliases"
    ".bashrc"
    ".bash_prompt"
    ".vimrc"
    ".profile" 
    ".slate" 
    ".tmux.conf"
)
PLUGINS=("https://github.com/hdima/python-syntax.git"
    "https://github.com/kien/ctrlp.vim"
    "https://github.com/bling/vim-airline"
    "https://github.com/kien/ctrlp.vim"
    "https://github.com/tpope/vim-fugitive"
    "https://github.com/junegunn/seoul256.vim.git" 
    "https://github.com/Valloric/YouCompleteMe"
    "https://github.com/FredKSchott/CoVim.git"
    "https://github.com/tomasr/molokai"
)
#Create folders
mkdir -p ~/.olddotfiles #backup for old dots
mkdir -p ~/.vim/bundle #folder for vim plugins
#create backup and symlinks to dotfiles
for file in "${DOTFILES[@]}"
do
    if [ -e ~/$file ]; then
        mv ~/$file ~/.olddotfiles/$file.old
    fi
    ln -s ~/.dotfiles/$file ~/$file
done

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
    else
        echo "Installing $PLUGINNAME addon.." 
        cd ~/.vim/bundle/ && git clone $P
    fi
done

# Reload dotfiles
source ~/.bashrc
