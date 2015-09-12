# some more ls aliases
alias ls='ls --color=auto '
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

#Misc#
alias ..="cd ../"
alias ...=".. && .."
alias c='clear'
alias vi='vim'
alias nano='vim'
alias tma='tmux attach #'
alias tmux='tmux -2' #256 color

#_UniAliases_#
alias sw="cd ~/aau/sw7/"
alias swpull="sw; pull;"
alias op="open master.pdf"
alias mm="make clean && make"
alias mop="make && op"

#_GitAliases_#
alias pull='git pull'
alias push='git push'
alias st='git status'
#alias cm="git commit . -m \"$fortune -s zippy\" && . ~/.bashrc"
#alias cm="git commit -a -m \"$(fortune -n45 -s zippy)\" && . ~/.bashrc"
#alias cmc="git commit -a -m \"$(command cowsay $(fortune -n45 -s zippy))\" && . ~/.bashrc"

#_MacSpecificAliases_#
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
