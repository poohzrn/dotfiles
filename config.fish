set -x EDITOR nvim
set -x editor nvim
set -x ANDROID_SDK_ROOT /Users/lasse/Library/Android/sdk
set -x GIT_EDITOR nvim
set -x XDG_CONFIG_HOME $HOME/.config
set -x FISH_CONFIG $HOME/git/dotfiles/config.fish
set -x SCRIPTS $HOME/git/dotfiles/scripts
set -x GITFOLDER ~/git

#  Monitors {{{ #
set -U LAPMONITOR LVDS1
set -U LMONITOR DP2
set -U RMONITOR DP1
#  }}} Monitors #
#Colors
set fish_color_cwd white --bold
set fish_pager_color_prefix red
set fish_search_match --background=red

#Disable greeting
set fish_greeting ''

# Fish Prompt {{{ #
function fish_prompt
    set_color $fish_color_cwd   ; printf '%s' (whoami)
    set_color red --bold        ; printf '@'
    set_color $fish_color_cwd   ; printf '%s'(hostname) ; printf ' '
    set_color $fish_color_cwd   ; printf '%s' (prompt_pwd)
    set_color normal            ; printf '%s\n~>' (__fish_git_prompt)
    set_color normal
end
#       Git integration {{{ #
     set __fish_git_prompt_showdirtystate 'yes'
     set __fish_git_prompt_showstashstate 'yes'
     set __fish_git_prompt_showupstream 'yes'
     set __fish_git_prompt_color_branch red
     set __fish_git_prompt_char_dirtystate '⚡'
     set __fish_git_prompt_char_stagedstate '→'
     set __fish_git_prompt_char_stashstate '✔'
     set __fish_git_prompt_char_upstream_ahead '↑'
     set __fish_git_prompt_char_upstream_behind '↓'
#       }}} Git integration #

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

function dvi-lap
	eval xrandr --output $LAPMONITOR --auto;
    eval xrandr --output $LMONITOR --auto --left-of $LAPMONITOR --primary;
end

function dvi
	eval xrandr --output $LAPMONITOR --off;
    eval xrandr --output $RMONITOR --auto --primary;
end

function dock
    xrandr --output $LAPMONITOR --off;
    eval xrandr --output $RMONITOR --auto;
    eval xrandr --output $LMONITOR --auto --left-of $RMONITOR --primary;
    set-wallpaper;
end
function dock-left
    xrandr --output $LAPMONITOR --off;
    eval xrandr --output $LMONITOR --auto --primary;
    set-wallpaper;
end
function dock-right
    xrandr --output $LAPMONITOR --off;
    eval xrandr --output $RMONITOR --auto --primary;
    set-wallpaper;
end

function dock2
    xrandr --output $LAPMONITOR --off;
    eval xrandr --output $RMONITOR --rotate right --auto;
    eval xrandr --output $LMONITOR --auto --left-of $RMONITOR --primary;
    set-wallpaper;
end
function vga-above
	xrandr --output $LAPMONITOR --auto;
    xrandr --output VGA1 --auto --primary --above $LAPMONITOR $argv;
end
function vga-double
	xrandr --output $LAPMONITOR --auto;
    xrandr --output VGA1 --primary $argv;
end
function dvi-double
	xrandr --output $LAPMONITOR --auto;
    xrandr --output $RMONITOR --primary $argv;
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

#  }}} Misc functions #
#~> ~> ~> ~> ~> ~> ~> ~> ~> ~>

# start X at login
#if status --is-login
#    if test -z "$DISPLAY" -a $XDG_VTNR -eq 1
#        exec startx -- -keeptty
#        makeCapsEsc
#    end
#end

# abbh {{{ #
abbr -a why "aptitude why"
abbr -a apt "sudo apt"
abbr -a as "aptitude search"
abbr -a G "ls -l | grep -i"
#}}}

#  Misc aliases {{{ #
#alias sl "ls"
alias sleep "pm-hibernate"
alias c "clear"
alias g "cd  $GITFOLDER; clear; ls"
alias q "exit"
alias :q "exit"
alias r "ranger"
alias updatevim "sudo -v; g; cd vim; git pull; configurevim; make clean; make; sudo make install"
alias updateneovim "sudo -v; g; cd neovim; git pull; rm -rf build;  make clean; make CMAKE_BUILD_TYPE=RelWithDebInfo; sudo make install"
alias set-wallpaper "feh --bg-fill ~/.wallpaper.jpg"
#Some more alias to avoid making mistakes:
alias rm "rm -i"
alias cp "cp -i"
alias mv "mv -i"
#  Music
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
alias sw "cd $GITFOLDER/sw10-report/report"
alias swc "cd $GITFOLDER/sw10-code/"

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
alias configurevim " ./configure \
  --enable-gui=no \
  --without-x \
  --enable-multibyte \
  --with-tlib=ncurses \
  --enable-cscope \
  --with-features=huge \
  --disable-nls \
  --enable-perlinterp \
  --enable-pythoninterp \
  --enable-rubyinterp \
  --enable-termtruecolor"

# django {{{
alias djr "python3 manage.py runserver"
alias djt "python3 manage.py test"
alias djm "python3 manage.py makemigrations meetpeople; python3 manage.py migrate"
# }}} django
alias sonosm "python3 $GITFOLDER/dotfiles/scripts/sonos-ctl.py mute"
alias sonosu "python3 $GITFOLDER/dotfiles/scripts/sonos-ctl.py unmute"

function weather --argument-names 'city'
    if test -n "$city"
        curl wttr.in/~$argv
    else
		curl wttr.in
	end
end
# Changelog

function clog --argument-names 'package'
    if test -z $package
        tail -3 /var/log/apt/history.log
    else
        zless "/usr/share/doc/$package/changelog.Debian.gz"
    end
end
function updatepippackages
    sudo -v;
    eval pip3 freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 sudo pip3 install -U
    pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 sudo pip install -U
end

function tm --argument-names 'new'
  set -lx session
  set -lx newsession "$new"
  set -lx session (tmux list-sessions -F "#{session_name}" | fzf --query="$new" --select-1 --exit-0) ; tmux attach-session -t $session ; or tmux new-session -s $newsession
  end

#vim: fdm=marker
