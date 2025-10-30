#!/usr/bin/env bash

# Error check
set -e

# Setup user scripts
echo "Stowing user scripts..."
stow user-scripts

# Setup system scripts
echo "Stowing system scripts... (Requires sudo)"
sudo stow -t / system-scripts
