#SSH
alias ukuk='ssh jumphost'
alias obs='ssh observium'
alias ssw='ssh sw'
alias tvh='ssh tvheadend'
alias pi='ssh root@pi'

#Misc
alias ..="cd ../"
alias c='clear'
alias g='cd ~/git/ && clear; ls' 
alias r='ranger'
alias q='exit'
alias flux='cd /home/lasse/programs/flux && ./xflux -l 57'
alias sleep='sudo -v; afk; sudo sh -c "echo mem > /sys/power/state"'
alias update='~/git/dotfiles/scripts/install.sh'
alias afk='~/git/dotfiles/scripts/lock.sh'
alias apt='sudo apt'
alias updateDisplay='xrandr --output VGA1 --auto --right-of LVDS1'

#ls
export LS_OPTIONS='--color=auto'
eval "`dircolors`"
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -l'

#Some more alias to avoid making mistakes:
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

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

