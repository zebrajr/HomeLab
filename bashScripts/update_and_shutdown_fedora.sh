#!/bin/bash

SHUTDOWN_TIMEOUT=10

# make sure we have permissions
#
if [ "$EUID" -ne 0 ]; then
    echo "######"
    echo "This script must be run with sudo."
    echo "Attempting to rerun with sudo..."
    echo "######"
    
    # Re-run the script with sudo
    exec sudo "$0" "$@"
    
    # If we reach here, sudo failed to execute
    echo "Failed to access sudo. Exiting."
    exit 1
fi

echo ""
echo "sudo permissions available. Starting"
echo ""

sudo dnf check -y
sudo dnf check-update -y
sudo dnf update -y
sudo flatpak update -y
sudo flatpak repair
sudo flatpak uninstall --unused -y
sudo dnf autoremove -y
sudo dnf clean all -y


echo ""
echo "Press any key withing $SHUTDOWN_TIMEOUT seconds to cancel shutdown."
echo ""

if read -t $SHUTDOWN_TIMEOUT -n 1; then
    echo "Shutdown Canceled"
else
    echo "Shutting down"
    sudo shutdown now
fi
