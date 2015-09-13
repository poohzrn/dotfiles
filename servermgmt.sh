#!/bin/sh
tmux new-session -d -s server
tmux splitw -v 
tmux selectp -t 2
tmux splitw -h 
tmux selectp -t 2
tmux splitw -h 
tmux selectp -t 2
tmux send-keys -t 1 'dev' enter C-1
tmux send-keys -t 2 'ukuk' enter C-1
tmux send-keys -t 3 'debian' enter C-1
tmux send-keys -t 4 'obs' enter C-1

tmux set synchronize-panes on 
tmux selectp -t 1
tmux -2 attach-session -t server
