#set -U fish_user_paths $fish_user_paths ~/git/dotfiles/scripts
set -U EDITOR nvim
#Colors
set fish_color_cwd white --bold
set fish_pager_color_prefix red
set fish_search_match --background=red

#Disable greeting
set fish_greeting ''

#  Fish Prompt {{{ #
function fish_prompt
    set_color $fish_color_cwd   ; printf '%s' (whoami)
    set_color red --bold        ; printf '@'
    set_color $fish_color_cwd   ; printf '%s'(hostname) ; printf ' '
    set_color $fish_color_cwd   ; printf '%s' (prompt_pwd)
    set_color normal            ; printf '%s\n~>' (__fish_git_prompt)
    set_color normal
end
    #  Git integration {{{ #
    set __fish_git_prompt_showdirtystate 'yes'
    set __fish_git_prompt_showstashstate 'yes'
    set __fish_git_prompt_showupstream 'yes'
    set __fish_git_prompt_color_branch red
    set __fish_git_prompt_char_dirtystate '⚡'
    set __fish_git_prompt_char_stagedstate '→'
    set __fish_git_prompt_char_stashstate '✔'
    set __fish_git_prompt_char_upstream_ahead '↑'
    set __fish_git_prompt_char_upstream_behind '↓'
    #  }}} Git integration #
#  }}} Fish Prompt #

#  Misc functions {{{ #
#Enable VGA output
function vga
	xrandr --output LVDS1 --auto --primary --output VGA1 --auto --right-of LVDS1 $argv;
end
#Enable DVI output
function hdmi
	xrandr --output LVDS1 --auto --primary --output HDMI3 --auto --right-of LVDS1 $argv;
end
#Enable acpid & debug
function fuckdebian
    sudo acpid -d &
end
function dock
    ~/git/dotfiles/scripts/thinkpad-undock.sh ; ~/git/dotfiles/scripts/thinkpad-dock.sh
end
#Update git folders
function updategit
    for folder in (ls ~/git/); 
        cd ~/git/$folder; echo "updating $folder"; git pull;
    end
end
#Bind CapsLock to ESC if tapped CTRL otherwise; neat
function makeCapsEsc
    xcape -e 'Caps_Lock=Escape;Control_L=Escape;Control_R=Escape'
end
# List installed packages sorted by size
function packages
    dpkg-query -Wf '${Installed-Size}\t${Package}\n' | sort -n
end
#  }}} Misc functions #
#~> ~> ~> ~> ~> ~> ~> ~> ~> ~>

# start X at login
if status --is-login
    if test -z "$DISPLAY" -a $XDG_VTNR -eq 1
        exec startx -- -keeptty
        makeCapsEsc
    end
end

#  Misc aliases {{{ # 
alias c "clear"
alias g "cd  ~/git; clear; ls"
alias q "exit"
alias r "ranger"
alias update "sudo apt-get update; sudo apt-get upgrade; vim -c :PlugUpdate -c :q -c :q"
alias updatevim "g; cd vim; git pull; configurevim; make clean; make; sudo make install"
#Display
alias set-wallpaper "feh --bg-fill ~/.wallpaper.jpg"
#Some more alias to avoid making mistakes:
alias rm "rm -i"
alias cp "cp -i"
alias mv "mv -i"
#  Music
alias spotify "chromium https://play.spotify.com/browse"
#  }}} Misc aliases #

#  Tmux Aliases {{{ #
alias tma "tmux attach-session -t"
alias tmux "tmux -2" #256 color
alias tmuxls "tmux list-sessions"
alias tmate "tmate -2" #256 color
alias mgmt "~/scripts/servermgmt.sh"
alias dmgmt "tmux kill-session -t mgmt"
#  }}} Tmux Aliases #

#Uni
alias sw "cd ~/git/sw7/"

#  Git {{{
alias pull "git pull"
alias push "git push"
alias st "git status -s"
alias gl "git log --graph --pretty=format:'%C(bold blue)%h %Creset%C(bold red)%an%Creset:%Creset %s %Cgreen(%cr)' --abbrev-commit --date=relative -n"
alias lo "git shortlog --summary --numbered"

#Git-log;
function l
    git log --graph --pretty=format:'%C(bold blue)%h %Creset%C(red)%an%Creset:%Creset %s %Cgreen(%cr)' --abbrev-commit --date=relative -n20
end
#Git-diff;
function d
    git diff-index --quiet HEAD -- OR clear; git --no-pager diff --patch-with-stat
end
#Switch branch;
function go
    git checkout $argv 2> /dev/null; and return; or git checkout -b $argv
end
#  }}} Git
alias configurevim "./configure --enable-pythoninterp --enable-cscop --enable-gui=autoe --enable-gtk2-check --enable-gnome-check --with-features=huge"
#vim: fdm=marker
