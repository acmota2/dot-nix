# .nix - NixOS configuration

My flake NixOS configuration - always in expansion.

## Preview

![preview](./preview.png)

## Machines

| Hostname | Type | Usage | Short description |
| -------- | ---- | ----- | ---- |
| **EnderDragon** | Desktop | Workstation / Gaming | My main machine, used for all sorts of workloads. |
| **Allay** | Laptop | Portable Workstation | My portable machine, used for work on the go. |

## Home-manager

This configuration is automatically enabled for all machines.

A standalone configuration is also available for use on non-NixOS systems.

## Applications in use

### Desktop

- [foot](./desktop/foot/default.nix)
- [hyprland](./desktop/tiling/hyprland/default.nix)
- [mango](./desktop/tiling/mangowc/default.nix)
- [mako](./desktop/tiling/mako/default.nix)
- [waybar](./desktop/tiling/waybar/default.nix)
- [wofi](./desktop/tiling/wofi/default.nix)
- [walker](./desktop/tiling/walker/default.nix)
- [gamescope](./desktop/gamescope/default.nix)
- [ly](./display-manager/ly/default.nix)
- [regreet](./display-manager/regreet/default.nix)

### Development

- [nixvim](http://github.com/acmota2/dot-nix-neovim) (moved to another repository)
- [tmux](./apps/terminal/tmux/default.nix)
- [podman](./dev/virtualization/podman.nix)
- [qemu](./dev/virtualization/qemu.nix)
- [aws](./dev/aws/default.nix)

### Terminal

- [btop](./apps/terminal/btop/default.nix)
- [macchina](./apps/terminal/macchina/default.nix)
- [starship](./apps/terminal/starship/default.nix)
- [ssh](./apps/terminal/ssh/default.nix)

### Multimedia

- [pipewire](./apps/multimedia/audio/default.nix)
- [vlc](./apps/multimedia/video.nix)

### Games

- [minecraft](./apps/games/minecraft/default.nix)

### Shell

- [bash](./system/shell/bash.nix)
- [nushell](./system/shell/nushell.nix)
