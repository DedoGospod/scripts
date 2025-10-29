#!/usr/bin/env bash

# Error check
set -e

# Setup user scripts
echo "Stowing user scripts..."
stow user-scripts

# Setup system scripts
echo "Stowing system scripts... (Requires sudo)"
sudo stow -t / system-scripts

# Conditionally install the nix multiuser pkg manager
read -r -p "Would you like to run the nix-multiuser pkg manager install script? (Y/n): " install_nix

NIXSCRIPT_DIR="$HOME/scripts/nix"

if [[ "$install_nix" =~ ^[Yy]$ || -z "$install_nix" ]]; then
    echo "Installing nix-multiuser"
    echo "Making nix-packages-install.sh executable"
    cd "$NIXSCRIPT_DIR"
    chmod +x nix-multiuser-install.sh
    chmod +x nix-packages-install.sh
    ./nix-multiuser-install.sh

else
    echo "Skipping nix multiuser install... "
fi

echo "Scripts sucessfully stowed"
