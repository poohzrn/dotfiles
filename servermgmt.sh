#!/bin/sh
tmux new-session -d -s mgmt
tmux splitw -v 
tmux splitw -h 
tmux splitw -h 
tmux send-keys -t 1 'dev' enter C-1
tmux send-keys -t 2 'ukuk' enter C-1
tmux send-keys -t 3 'debian' enter C-1
tmux send-keys -t 4 'obs' enter C-1
tmux send-keys -t 5 'swdev' enter C-1

tmux select-layout tiled

tmux set synchronize-panes on 
tmux selectp -t 1
tmux -2 attach-session -t mgmt
