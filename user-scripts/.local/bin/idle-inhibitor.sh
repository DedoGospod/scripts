#!/bin/bash

# Check if hypridle is running
HYPRIDLE_RUNNING=$(pgrep -x "hypridle")

if [ -n "$HYPRIDLE_RUNNING" ]; then
    # hypridle is running, so stop it and stop sway-audio-idle-inhibit
    systemctl --user stop --now hypridle.service
    killall "wayland-pipewire-idle-inhibit" # Kill the sway-audio-idle-inhibit process
    notify-send -t 1000 "SLEEP DISABLED."
else
    # hypridle is not running, so start it and start sway-audio-idle-inhibit
    systemctl --user start --now hypridle.service
    /usr/bin/wayland-pipewire-idle-inhibit &
    notify-send -t 1000 "SLEEP ENABLED"
fi
