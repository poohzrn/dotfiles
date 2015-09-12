#!/usr/bin/env bash
##reata symlinks
if [ -e ~/.bash_aliases ]; then
    mv ~/.bash_aliases ~/.bash_aliases.old
fi
ln -s ~/.dotfiles/.bash_aliases ~/.bash_aliases

if [ -e ~/.bash_aliases_private ]; then
    mv ~/.bash_aliases_private ~/.bash_aliases.private.old
fi
ln -s ~/.dotfiles/private/.bash_aliases_private ~/.bash_aliases_private
if [ -e ~/.bashrc ]; then
    mv ~/.bashrc ~/.bashrc.old
fi
ln -s ~/.dotfiles/.bashrc ~/.bashrc
if [ -e ~/.bash_prompt ]; then
    mv ~/.bash_prompt ~/.bash_prompt.old
fi
ln -s ~/.dotfiles/.bash_prompt ~/.bash_prompt
if [ -e ~/.vimrc ]; then
    mv ~/.vimrc ~/.vimrc.old
fi
ln -s ~/.dotfiles/.vimrc ~/.vimrc
if [ -e ~/.tmux.conf ]; then
    mv ~/.tmux.conf ~/.tmux.conf.old
fi
ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf

if [ -e ~/.profile ]; then
    mv ~/.profile ~/.profile.old
fi
ln -s ~/.dotfiles/.profile ~/.profile

mkdir -p ~/.vim/autoload
mkdir -p ~/.vim/bundle

if [ ! -e ~/.vim/autoload/pathogen.vim ]; then
    echo "installing pathogen.."
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
    echo "done"
fi
echo "Installing and updating vim addons.."
if [ -e ~/.vim/bundle/python-syntax ]; then
    echo "Updating python-syntax addon.." 
    cd ~/.vim/bundle/python-syntax && git pull
else
    echo "Installing python-syntax addon.." 
    cd ~/.vim/bundle/ &&  git clone https://github.com/hdima/python-syntax.git
fi

if [ -e ~/.vim/bundle/vim-airline ]; then
    echo "Updating vim-airline addon.."
    cd ~/.vim/bundle/vim-airline/ && git pull
else
    echo "Installing vim-airline addon.."
    cd ~/.vim/bundle/ && git clone https://github.com/bling/vim-airline
fi

if [ -e ~/.vim/bundle/ctrlp.vim ]; then
    echo "Updating control p addon.."
    cd ~/.vim/bundle/ctrlp.vim/ && git pull
else
    echo "Installing vim-airline addon.."
    cd ~/.vim/bundle/ && git clone https://github.com/kien/ctrlp.vim
fi
source ~/.bashrc
