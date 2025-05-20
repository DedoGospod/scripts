#!/bin/bash

# Check if hypridle is running
HYPRIDLE_RUNNING=$(pgrep -x "hypridle")

if [ -n "$HYPRIDLE_RUNNING" ]; then
    # hypridle is running, so stop it and stop sway-audio-idle-inhibit
    killall hypridle
    killall "sway-audio-idle-inhibit"     # Kill the sway-audio-idle-inhibit process
    notify-send "SLEEP DISABLED." -t 1000 # 1 second notification
else
    # hypridle is not running, so start it and start sway-audio-idle-inhibit
    systemctl --user start --now hypridle.service
    # Start sway-audio-idle-inhibit 
    /usr/bin/sway-audio-idle-inhibit &
    notify-send "SLEEP ENABLED" -t 1000 # 1 second notification
fi
