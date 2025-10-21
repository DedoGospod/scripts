#!/bin/bash

# --- Configuration ---
# Set the base directory of the dotfiles repository (where this script resides)
SCRIPTS_DIR="$(dirname "$(realpath "$0")")"
# Directory where GNU Stow will run for user-level files
USER_STOW_DIR="$HOME"
# Directory where GNU Stow will run for system-level files (the root directory)
SYSTEM_STOW_DIR="/"

# -----------------------------------------------------------------------------
## 🗂️ Directory Creation (NEW SECTION)
# This ensures both target directories exist before Stow attempts to link into them.
# -----------------------------------------------------------------------------

echo "🛠️ Ensuring target directories exist..."

# Create user-local bin directory
mkdir -p "$USER_STOW_DIR/.local/bin"
if [ $? -eq 0 ]; then
    echo "✅ Checked/Created ~/.local/bin"
else
    echo "❌ Failed to create ~/.local/bin"
    exit 1
fi

# Create system-local bin directory (requires sudo)
sudo mkdir -p "/usr/local/bin"
if [ $? -eq 0 ]; then
    echo "✅ Checked/Created /usr/local/bin"
else
    echo "❌ Failed to create /usr/local/bin (Did you enter your password?)"
    exit 1
fi

echo "--------------------------------------------------"

# -----------------------------------------------------------------------------
## ⚙️ Local Scripts: Stowing to ~/.local/bin
# -----------------------------------------------------------------------------

echo "⚙️ Stowing user-level scripts into ~/.local/bin..."

# Navigate to the directory containing the 'local_bin' package
cd "$SCRIPTS_DIR" || { echo "Error: Cannot navigate to $SCRIPTS_DIR"; exit 1; }

# Stow the 'local_bin' package.
stow --dir="$SCRIPTS_DIR" --target="$USER_STOW_DIR" local_bin

if [ $? -eq 0 ]; then
    echo "✅ Successfully stowed scripts to ~/.local/bin."
else
    echo "❌ Failed to stow scripts for ~/.local/bin. Check for conflicts or errors."
fi

echo "--------------------------------------------------"

# -----------------------------------------------------------------------------
## ⚠️ System Scripts: Stowing to /usr/local/bin
# -----------------------------------------------------------------------------

echo "⚠️ Stowing system-level scripts into /usr/local/bin (requires sudo)..."

# Navigate back to the parent directory of the 'usr_local_bin' package
cd "$SCRIPTS_DIR" || { echo "Error: Cannot navigate to $SCRIPTS_DIR"; exit 1; }

# Stow the 'usr_local_bin' package using sudo and specifying the root directory
# as the target.
sudo stow --dir="$SCRIPTS_DIR" --target="$SYSTEM_STOW_DIR" usr_local_bin

if [ $? -eq 0 ]; then
    echo "✅ Successfully stowed scripts to /usr/local/bin."
else
    echo "❌ Failed to stow scripts for /usr/local/bin. Check for conflicts or errors."
    echo "   (This often happens if you don't have sufficient permissions or if files already exist.)"
fi

echo "--------------------------------------------------"
echo "✨ Stow operation complete."
