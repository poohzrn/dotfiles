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
# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac
# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
# Run bash-prompt
if [ -f ~/.bash_prompt ]; then
    . ~/.bash_prompt
fi
if [ -f ~/.bash_aliases_private ]; then
    . ~/.bash_aliases_private
fi
