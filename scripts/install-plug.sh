#!/bin/bash
#Installs vim-plug

mkdir -p ~/.vim/autoload
if [ ! -e ~/.vim/autoload/plug.vim ]; then
    echo "installing vim-plug.."
    cd ~/.vim/autoload && { wget https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim ; cd -; }
else
    echo "vim-plug already installd - updating"
    vim -c :PlugUpgrade -c :x
fi
