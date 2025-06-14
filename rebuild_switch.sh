#!/bin/sh

HOSTNAME=$(cat /proc/sys/kernel/hostname)
echo
echo "Nix rebuild-switch helper"
echo
read -r -p "I will ask to sudo now, do you want to proceed? [y/N]" response
case "$response" in
    [yY][eE][sS]|[yY])
        sudo cp /etc/nixos/hardware-configuration.nix ./machines/.
        ;;
    *)
        exit 1
        ;;
esac
sudo nixos-rebuild switch --flake ~/repos/dot-nix#$HOSTNAME
