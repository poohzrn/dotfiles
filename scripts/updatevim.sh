#!/usr/bin/env bash
mkdir -p ~/.vim/bundle #folder for vim plugins
mkdir -p ~/.vim/autoload
# Install Pathogen
if [ ! -e ~/.vim/autoload/pathogen.vim ]; then
    echo "installing pathogen.."
    cd ~/.vim/autoload && { wget https://tpo.pe/pathogen.vim ; cd -; }
else
    echo "updating pathogen.."
    cd ~/.vim/autoload && { rm -f pathogen.vim ; wget https://tpo.pe/pathogen.vim ; }
fi

# Plugins for vim
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
    "https://github.com/bling/vim-bufferline"
    "https://github.com/scrooloose/syntastic"
    "https://github.com/terryma/vim-multiple-cursors"
)
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
