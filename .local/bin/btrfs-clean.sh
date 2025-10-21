#!/usr/bin/env bash

set -e

sudo btrfs scrub start /
sudo btrfs balance start -dusage=10 -musage=10 /


# For automatic monthly btrfs cleaning, do: sudo mv /.local/bin/btrfs-clean.sh /etc/cron.monthly
# Change the name of the file (cron doesn't run scripts with . in their filename) 
# The command for this is: cd /etc/cron.monthly && sudo mv btrfs-clean.sh btrfs-clean-job
