#vim: fdm=marker
# Prompt Colors
B_BLACK='\[\033[01;30m\]'
B_RED='\[\033[01;31m\]'
B_GREEN='\[\033[01;32m\]'
B_YELLOW='\[\033[01;33m\]'
B_BLUE='\[\033[01;34m\]'
B_PURPLE='\[\033[01;35m\]'
B_TEAL='\[\033[01;36m\]'
B_WHITE='\[\033[01;37m\]'

BLACK='\[\033[00;30m\]'
RED='\[\033[00;31m\]'
GREEN='\[\033[00;32m\]'
YELLOW='\[\033[00;33m\]'
BLUE='\[\033[00;34m\]'
PURPLE='\[\033[00;35m\]'
TEAL='\[\033[00;36m\]'
WHITE='\[\033[00;37m\]'
export PS1="${GREEN}\u${RED} \w ${BLUE}\$${B_WHITE} \n\[$(tput sgr0)\]"
export GITFOLDER=~/git/
alias sl="ls"
alias l="ls -l"
alias sleep="pm-hibernate"
alias c="clear"
alias g="cd $GITFOLDER; clear; ls"
alias q="exit"
alias :q="exit"
alias r="ranger"
alias updatevim="sudo -v; g; cd vim; git pull; configurevim; make clean; make; sudo make install"
alias updateneovim="sudo -v; g; cd neovim; git pull; rm -rf build;  make clean; make CMAKE_BUILD_TYPE=RelWithDebInfo; sudo make install"
alias set-wallpaper="feh --bg-fill ~/.wallpaper.jpg"
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"
alias update="sudo apt update; sudo apt upgrade" #vim -c :PlugUpdate -c :q -c :q"
alias install="sudo apt install --no-install-recommends"
alias remove="sudo apt autoremove --purge"
alias tma="tmux attach-session -t"
alias tmux="tmux -2" #256 color
alias tmuxls="tmux list-sessions"
alias tmate="tmate -2" #256 color
alias tmgm="~/scripts/servermgmt.sh"
alias tdmgm="tmux kill-session -t mgmt"
alias pull="git pull"
alias push="git push"
alias st="git status -s"
alias gl="git log --graph --pretty=format:'%C(bold blue)%h %Creset%C(bold red)%an%Creset:%Creset %s %Cgreen(%cr)' --abbrev-commit --date=relative -n"
alias lo="git shortlog --summary --numbered"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
