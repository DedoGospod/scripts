#!/usr/bin/env bash

set -e

echo "Stowing user scripts..."
stow user-scripts.sh 

echo "Stowing system scripts... (Requires sudo)"
sudo stow -t / system-scripts


