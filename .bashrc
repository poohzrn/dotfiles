#ls color
export TERM=xterm-256color
export CLICOLOR=1
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
# keybindings
if [ -f ~/.Xmodmap ]; then
    xmodmap ~/.Xmodmap
fi
# autostart x when log in at tty 1
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
