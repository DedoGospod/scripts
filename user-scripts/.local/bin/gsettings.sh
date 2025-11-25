#!/usr/bin/env bash

echo "Changed the nautilus sort order to 'type'..."
gsettings set org.gnome.nautilus.preferences default-sort-order 'type'   
echo "Removed the 'recent' section from nautilus..."
gsettings set org.gnome.desktop.privacy remember-recent-files false
