#!/bin/bash
cd /home/pi/fanshim-python/examples
echo looking to kill any old tmux auto session
tmux kill-session -t auto
echo now start new tmux auto session 
tmux new-session -d -s auto 'python3 automatic.py --verbose --delay 2 --off-threshold 60 --on-threshold 65 --brightness 80'
