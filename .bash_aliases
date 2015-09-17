#SSH aliases
alias ukuk='ssh ukuk'
alias dev='ssh dev'
alias pi='ssh root@pi'
alias obs='ssh observium'
alias swdev='ssh sw'
alias debian='ssh debian'
alias mgmt='~/.dotfiles/servermgmt.sh'
#Misc#
alias ..="cd ../"
alias ...=".. && .."
alias c='clear'
alias vi='vim'
alias nano='vim'
alias tma='tmux attach #'
alias tmux='tmux -2' #256 color
alias dmgmt='tmux kill-session -t mgmt'

#_UniAliases_#
alias sw="cd ~/git/sw7/"
alias swpull="sw; pull;"
alias op="open master.pdf"
alias mm="make clean && make"
alias mop="make && op"


#_MacSpecificAliases_#
alias update='~/.dotfiles/install.sh && bup;'
alias poweroff='sudo /sbin/shutdown -h now'
alias afk='/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend'
alias sleep='pmset sleepnow'
alias wifi='sudo ifconfig en0 down && sudo ifconfig en0 up'

#_MiscAliases_#
alias google=search
#Home Brew Aliases
alias bs=bs 		#Brew Search
alias bi=bi 		#Brew Install
alias bu=bu 		#Brew Uninstall
alias cs=cs 		#Brew Cask Search
alias ci=ci 		#Brew Cask Install
alias cu=cu 		#Brew Cask Uninstall
alias bl='brew list'	#Brew List
alias bup='brew update && brew upgrade'

#_Functions_#
	#Git
	commit() {
    		git commit . -m "$1_$2_$3_$4_$5_$6" 
	}
	#Misc
	search(){ #Serach On Google
    	search=""
    	echo Googling: $@
    	for term in $@; do
		search="$search%20$term"
    	done
    		open http://www.google.com/search?q=$search
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
