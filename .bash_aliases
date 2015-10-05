#SSH
alias ukuk='ssh ukuk'
alias dev='ssh dev'
alias pi='ssh root@pi'
alias obs='ssh observium'
alias we='ssh websrv'
alias debian='ssh debian'

#Misc
alias ..="cd ../"
alias c='clear'
alias g='cd ~/git/ && clear; ls' 
alias flux='cd /home/lasse/programs/flux && ./xflux -l 57'
alias sleep='sudo -v; afk; sudo sh -c "echo mem > /sys/power/state"'
alias update='~/git/dotfiles/scripts/install.sh'
alias afk='~/git/dotfiles/scripts/lock.sh'

#Tmux
alias tma='tmux attach' 
alias tmux='tmux -2' #256 color
alias tmate='tmate -2' #256 color
alias mgmt='~/scripts/servermgmt.sh'
alias dmgmt='tmux kill-session -t mgmt'

#Uni
alias sw="cd ~/git/sw7/"
alias swpull="sw; pull;"
alias mm="make clean && make"

#Git
alias pull='git pull'
alias push='git push'
alias st='git status -s'
alias d='git diff-index --quiet HEAD -- || clear; git --no-pager diff --patch-with-stat'
alias go=co
alias l="git log --graph --pretty=format:'%C(bold blue)%h %Creset%C(red)%an%Creset:%Creset %s %Cgreen(%cr)' --abbrev-commit --date=relative -n20"
alias gl="git log --graph --pretty=format:'%C(bold blue)%h %Creset%C(bold red)%an%Creset:%Creset %s %Cgreen(%cr)' --abbrev-commit --date=relative -n"
alias lo='git shortlog --summary --numbered'
co(){
    git checkout -b $1 2> /dev/null || git checkout $1
}

#OSX
alias wifi='sudo ifconfig en0 down && sudo ifconfig en0 up'
#Home Brew
alias bs=bs 		#Brew Search
alias bi=bi 		#Brew Install
alias bu=bu 		#Brew Uninstall
alias cs=cs 		#Brew Cask Search
alias ci=ci 		#Brew Cask Install
alias cu=cu 		#Brew Cask Uninstall
alias bl='brew list' #Brew List
alias bup='brew update && brew upgrade'

#Functions

#Git
commit() {
    git commit . -m "$1_$2_$3_$4_$5_$6" 
}

#Home Brew Functions
bs(){
    brew search "$1"
}
bi(){ 
    brew install "$1"
}
bu(){
    brew uninstall "$1"
}
cs(){
    brew cask search "$1"
}
ci(){ 
    brew cask install --appdir="/Applications" "$1"
}
cu(){
    brew cask uninstall "$1"
}
