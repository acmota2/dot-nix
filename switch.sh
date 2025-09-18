#!/bin/sh

HOSTNAME=$(cat /proc/sys/kernel/hostname)
USERNAME=$(whoami)
NIXOS=$(cat /etc/os-release | grep NixOS)
IS_NIXOS=$?
echo
echo "Nix rebuild-switch helper"
echo
if [ $IS_NIXOS -eq 0 ]; then
    read -r -p "I will ask to sudo now, do you want to proceed? [y/N] " response
    case "$response" in
        [yY][eE][sS]|[yY])
            WSL=$(uname -a | grep WSL)
            IS_WSL=$?
            if [[ $IS_WSL -ne 0 ]]; then
                sudo cp /etc/nixos/hardware-configuration.nix ./machines/$HOSTNAME.nix
            fi
            sudo nixos-rebuild switch --flake .#$HOSTNAME
            ;;
        *)
            exit 1
            ;;
    esac
else
    nix run home-manager -- switch --flake .#$USERNAME
fi
