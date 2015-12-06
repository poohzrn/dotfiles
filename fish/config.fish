## fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch red

# Status Chars
set __fish_git_prompt_char_dirtystate '⚡'
set __fish_git_prompt_char_stagedstate '→'
set __fish_git_prompt_char_stashstate '✔'
set __fish_git_prompt_char_upstream_ahead '↑'
set __fish_git_prompt_char_upstream_behind '↓'

set fish_color_cwd white --bold
set fish_greeting ''

function fish_prompt
        set last_status $status
        set_color $fish_color_cwd
        printf '%s' (prompt_pwd)
        set_color normal
        printf '%s ' (__fish_git_prompt)
       set_color normal
end
#Enable VGA output
function vga
	xrandr --output LVDS1 --auto --primary --output VGA1 --auto --right-of LVDS1 $argv;
end
function fuckdebian
    sudo acpid -d &
end

#
#Misc aliases
alias c "clear"
alias g "cd ~/git; clear; ls"
alias q "exit"
alias r "ranger"
alias update "sudo apt-get update; sudo apt-get upgrade; vim -c :PlugUpdate -c :q -c :q"
#
#acpid bug
alias fuckdebian "sudo bash -c 'acpid -d &'"
#Display
alias set-wallpaper "feh --bg-fill ~/.wallpaper.jpg"
alias vga "xrandr --output LVDS1 --auto --primary --output VGA1 --auto --right-of LVDS1;  set-wallpaper"

#Some more alias to avoid making mistakes:
alias rm "rm -i"
alias cp "cp -i"
alias mv "mv -i"

#Tmux
alias tma "tmux attach-session -t"
alias tmux "tmux -2" #256 color
alias tmuxls "tmux list-sessions"
alias tmate "tmate -2" #256 color
alias mgmt "~/scripts/servermgmt.sh"
alias dmgmt "tmux kill-session -t mgmt"

#Uni
alias sw "cd ~/git/sw7/"

#Git
function d
    git diff-index --quiet HEAD -- OR clear; git --no-pager diff --patch-with-stat
end
#Switch branch
function go
    git checkout $argv 2> /dev/null; and return; or git checkout -b $argv
end
alias pull "git pull"
alias push "git push"
alias st "git status -s"
alias l "git log --graph --pretty=format:'%C(bold blue)%h %Creset%C(red)%an%Creset:%Creset %s %Cgreen(%cr)' --abbrev-commit --date=relative -n20"
alias gl "git log --graph --pretty=format:'%C(bold blue)%h %Creset%C(bold red)%an%Creset:%Creset %s %Cgreen(%cr)' --abbrev-commit --date=relative -n"
alias lo "git shortlog --summary --numbered"
