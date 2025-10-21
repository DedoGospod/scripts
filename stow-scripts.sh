#!/bin/bash

# --- Configuration ---
# Set the base directory of the dotfiles repository (where this script resides)
DOTFILES_DIR="$(dirname "$(realpath "$0")")"
# Directory where GNU Stow will run for user-level files
USER_STOW_DIR="$HOME"
# Directory where GNU Stow will run for system-level files (the root directory)
SYSTEM_STOW_DIR="/"

# --- Local Scripts: Stowing to ~/.local/bin ---

echo "⚙️ Stowing user-level scripts into ~/.local/bin..."

# Navigate to the directory containing the 'local_bin' package
cd "$DOTFILES_DIR" || { echo "Error: Cannot navigate to $DOTFILES_DIR"; exit 1; }

# Stow the 'local_bin' package.
stow --dir="$DOTFILES_DIR" --target="$USER_STOW_DIR" local_bin

if [ $? -eq 0 ]; then
    echo "✅ Successfully stowed scripts to ~/.local/bin."
else
    echo "❌ Failed to stow scripts for ~/.local/bin. Check for conflicts or errors."
fi

echo "--------------------------------------------------"

# --- System Scripts: Stowing to /usr/local/bin ---

echo "⚠️ Stowing system-level scripts into /usr/local/bin (requires sudo)..."

# Ensure the target directory structure exists
if ! sudo mkdir -p /usr/local/bin 2>/dev/null; then
    # Directory already exists, which is fine
    :
fi

# Navigate back to the parent directory of the 'usr_local_bin' package
cd "$DOTFILES_DIR" || { echo "Error: Cannot navigate to $DOTFILES_DIR"; exit 1; }

# Stow the 'usr_local_bin' package using sudo and specifying the root directory
# as the target. Files inside usr_local_bin should be structured as: usr_local_bin/usr/local/bin/...
sudo stow --dir="$DOTFILES_DIR" --target="$SYSTEM_STOW_DIR" usr_local_bin

if [ $? -eq 0 ]; then
    echo "✅ Successfully stowed scripts to /usr/local/bin."
else
    echo "❌ Failed to stow scripts for /usr/local/bin. Check for conflicts or errors."
    echo "   (This often happens if you don't have sufficient permissions or if files already exist.)"
fi

echo "--------------------------------------------------"
echo "✨ Stow operation complete."
