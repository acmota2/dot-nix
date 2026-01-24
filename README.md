# .nix - NixOS configuration

My flakes enabled multi-machine NixOS configuration - always in expansion.

## Machines

| Hostname | Type | Usage | Short description |
| -------- | ---- | ----- | ---- |
| **EnderDragon** | Desktop | Workstation / Gaming | My main machine, used for all sorts of workloads. |
| **Allay** | Laptop | Portable Workstation | My portable machine, used for work on the go. |
| **Squid** | WSL | Development | My WSL2 configuration for development on Windows. |

## Home-manager

This configuration is automatically enabled for all machines. A standalone configuration is also available for use on non-NixOS systems.

## Applications in use

### Desktop

- [foot](./desktop/foot)
- [hyprland](./desktop//hyprland)
- [hypridle](./desktop/hyprland/hypridle/default.nix)
- [hyprlock](./desktop/hyprland/hyprlock/default.nix)
- [mako](./desktop/tiling/mako/default.nix)
- [waybar](./desktop/hyprland/waybar/default.nix)

### Development

- [nixvim](./nixvim)
- [tmux](./tmux/default.nix)

### System

- [ly](./display-manager/ly/default.nix)
- [pipewire](./hardware/sound.nix)

### Utils

- [bash](./shell/bash.nix)
- [btop](./btop/default.nix)
- [macchina](./macchina/default.nix)
- [starship](./starship/default.nix)
