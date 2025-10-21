#!/usr/bin/env bash

set -e

sudo btrfs scrub start /
sudo btrfs balance start -dusage=10 -musage=10 /
