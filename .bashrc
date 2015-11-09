#ls color
export TERM=xterm-256color
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac
# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'

    # Show the currently running command in the terminal title:
    # http://www.davidpashley.com/articles/xterm-titles-with-bash.html
    show_command_in_title_bar()
    {
        case "$BASH_COMMAND" in
            *\033]0*)
                # The command is trying to set the title bar as well;
                # this is most likely the execution of $PROMPT_COMMAND.
                # In any case nested escapes confuse the terminal, so don't
                # output them.
                ;;
            *)
                echo -ne "\033]0;${BASH_COMMAND}\007"
                ;;
        esac
    }
    trap show_command_in_title_bar DEBUG
    ;;
*)
    ;;
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
setxkbmap -option 'caps:ctrl_modifier'
xcape -e 'Caps_Lock=Escape;Control_L=Escape;Control_R=Escape'
