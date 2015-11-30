#!/bin/sh
tmux new-session -d -s mgmt
tmux splitw -v
tmux splitw -v
tmux splitw -v
#tmux splitw -h

tmux send-keys -t 1 'ssh jumphost' enter C-1
tmux send-keys -t 2 'ssh observium' enter C-1
tmux send-keys -t 3 'ssh tvheadend' enter C-1
tmux send-keys -t 4 'ssh pi@pi' enter C-1

tmux select-layout tiled

tmux set synchronize-panes on 
tmux selectp -t 2
tmux -2 attach-session -t mgmt
