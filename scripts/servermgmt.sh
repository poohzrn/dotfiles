#!/bin/sh
tmux new-session -d -s mgmt
tmux splitw -v
tmux splitw -v
tmux splitw -v
#tmux splitw -h

tmux send-keys -t 1 'obs' enter C-1
tmux send-keys -t 2 'ssw' enter C-1
tmux send-keys -t 3 'tvh' enter C-1
tmux send-keys -t 4 'ukuk' enter C-1

tmux select-layout tiled

tmux set synchronize-panes on 
tmux selectp -t 2
tmux -2 attach-session -t mgmt
