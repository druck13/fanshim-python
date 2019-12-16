#!/bin/bash
cd /home/pi/fanshim-python/examples
echo looking to kill any old tmux auto session
tmux kill-session -t auto
