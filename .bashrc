#ls color
export TERM=xterm-256color
export CLICOLOR=1
export HVMOUTPUTFOLDER=~/git/sw7/code/hvm
export LSCOLORS=GxFxCxDxBxegedabagaced
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac
#ignore case
set completion-ignore-case On

# append to the history file, don't overwrite it
shopt -s histappend
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000
# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
# Run bash-prompt
if [ -f ~/.bash_prompt ]; then
    . ~/.bash_prompt
fi
# Local file for tokens / stuff
if [ -f ~/.private ]; then
    . ~/.private
fi
# Mac Specific aliases
if [ -f ~/.bash_aliases_mac ]; then
    . ~/.bash_aliases_mac
fi

# autostart x when log in at tty 1
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
# bind Capslock to Escape when tapped,
# Bind Capslock to Control when pressed
# depends on xcape
#setxkbmap -option 'caps:ctrl_modifier'
if ! -z xset q &>/dev/null; then

    if setxkbmap &>/dev/null; then
        setxkbmap -option 'caps:ctrl_modifier'
    fi
    if xcape &>/dev/null; then
        xcape -e 'Caps_Lock=Escape;Control_L=Escape;Control_R=Escape'
    fi
fi



[ -f ~/.fzf.bash ] && source ~/.fzf.bash
