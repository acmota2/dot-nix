#!/bin/sh

HOSTNAME=$(cat /proc/sys/kernel/hostname)
USERNAME=$(whoami)
NIXOS=$(uname -v | grep NixOS)
IS_NIXOS=$?
echo
echo "Nix rebuild-switch helper"
echo
if [ $IS_NIXOS -eq 0 ]; then
    read -r -p "I will ask to sudo now, do you want to proceed? [y/N] " response
    case "$response" in
        [yY][eE][sS]|[yY])
            sudo cp /etc/nixos/hardware-configuration.nix ./machines/$HOSTNAME.nix
            sudo nixos-rebuild switch --flake ~/repos/dot-nix#$HOSTNAME
            ;;
        *)
            exit 1
            ;;
    esac
else
    nix run home-manager -- --flake .#$USERNAME
fi
