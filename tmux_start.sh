#!/bin/bash
cd /home/pi/fanshim_pwm/examples
echo looking to kill any old tmux fanshim session
tmux kill-session -t auto
echo now new tmux fanshim session 
tmux new-session -d -s auto 'python3 automatic.py --verbose --delay 10 --off-threshold 60 --on-threshold 65 --noled False --brightness 80'
