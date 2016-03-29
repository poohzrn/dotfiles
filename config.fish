set -U EDITOR nvim
set -U editor nvim
set -U GIT_EDITOR nvim
set -U XDG_CONFIG_HOME $HOME/.config
set -U GITFOLDER ~/git
#  Monitors {{{ #
set -U LAPMONITOR LVDS1
set -U LMONITOR VGA1
set -U RMONITOR HDMI3
#  }}} Monitors #
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
	xrandr --output $LAPMONITOR --auto --primary --output VGA1 --auto --right-of $LAPMONITOR $argv;
end
#Enable DVI output
function hdmi
	xrandr --output $LAPMONITOR --auto --primary;
    xrandr --output $RMONITOR --auto --right-of $LAPMONITOR $argv;
end
#Docking setup
function dock
    xrandr --output $LAPMONITOR --off;
    eval xrandr --output $LMONITOR --auto --primary;
    eval xrandr --output $RMONITOR --auto --left-of $LMONITOR;
    set-wallpaper;
end
function vga-above
	xrandr --output $LAPMONITOR --auto --primary;
    xrandr --output $LMONITOR --auto --above $LAPMONITOR $argv;
end
#notdocking setup
function undock
    eval xrandr --output $RMONITOR --off;
    eval xrandr --output $LMONITOR --off;
    xrandr --output $LAPMONITOR --auto --primary;
    set-wallpaper;
end
#Update git folders
function updategit
    for folder in (ls $GITFOLDER);
        cd $GITFOLDER/$folder; echo "updating $folder"; git pull;
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
function sudo
    if test "$argv" = !!
        eval command sudo $history[1]
    else
        command sudo $argv
    end
end

function sudo
    if test "$argv" = !!
        eval command sudo $history[1]
    else
        command sudo $argv
    end
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
alias g "cd  $GITFOLDER; clear; ls"
alias q "exit"
alias r "ranger"
alias updatevim "sudo -v; g; cd vim; git pull; configurevim; make clean; make; sudo make install"
alias updateneovim "sudo -v; g; cd neovim; git pull; rm -rf build;  make clean; make CMAKE_BUILD_TYPE=Release; sudo make install"
alias set-wallpaper "feh --bg-fill ~/.wallpaper.jpg"
#Some more alias to avoid making mistakes:
alias rm "rm -i"
alias cp "cp -i"
alias mv "mv -i"
#  Music
alias spotify "chromium https://play.spotify.com/browse"
#  }}} Misc aliases #
#  APT {{{ #
alias update "sudo apt update; sudo apt upgrade" #vim -c :PlugUpdate -c :q -c :q"
alias install "sudo apt install --no-install-recommends"
alias remove "sudo apt autoremove --purge"
#  }}} APT #

#  Tmux Aliases {{{ #
alias tma "tmux attach-session -t"
alias tmux "tmux -2" #256 color
alias tmuxls "tmux list-sessions"
alias tmate "tmate -2" #256 color
alias tmgm "~/scripts/servermgmt.sh"
alias tdmgm "tmux kill-session -t mgmt"
#  }}} Tmux Aliases #

#Uni
alias sw "cd $GITFOLDER/sw8/"
alias swc "cd $GITFOLDER/sw8-code/"

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
# django {{{
alias djr "python3 manage.py runserver"
alias djt "python3 manage.py test"
alias djm "python3 manage.py makemigrations meetpeople; python3 manage.py migrate"
# }}} django
#vim: fdm=marker
