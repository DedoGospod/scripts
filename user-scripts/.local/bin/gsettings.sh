#!/usr/bin/env bash

# Show directories first
echo "Changed the nautilus sort order to 'type'..."
gsettings set org.gnome.nautilus.preferences default-sort-order 'type'   

# Remove the 'recent' section from nautilus
echo "Removed the 'recent' section from nautilus..."
gsettings set org.gnome.desktop.privacy remember-recent-files false

# Set the color scheme to dark
echo "Setting color-sceme to 'dark'..."
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

# Set dark theme environmental variables for qt applications
export QT_QPA_PLATFORMTHEME,qt6ct 
export QT_QPA_PLATFORMTHEME,qt5ct 

