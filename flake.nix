{
  description = "My machines";

  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/hyprland";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nixvim.url = "github:nix-community/nixvim";
    sops-nix.url = "github:Mic92/sops-nix";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { nixpkgs, sops-nix, ... }@inputs:
    let
      defaultUser = {
        gitEmail = "acmota2@gmail.com";
        gitUser = "acmota2";
        username = "acmota2";
      };

      default = [ ./. ];

      machineModules = [
        ./boot/kernel-mod
        ./hardware/nfs.nix
        ./multimedia
        ./virtualization/podman.nix
      ];

      sops = [
        ./sops
        sops-nix.nixosModules.sops
      ];

      mySystems = {
        EnderDragon = {
          modules =
            default
            ++ machineModules
            ++ [
              ./games
              ./games/minecraft
              ./hardware/bluetooth.nix
            ];

          specialArgs = {
            desktop = "hyprland";
            graphics = "amd";
            hdr = true;
            monitors = (import ./monitors).aoc;
          };
        };

        Allay = {
          modules =
            default
            ++ machineModules
            ++ sops
            ++ [
              ./games
              ./hardware/bluetooth.nix
              ./hardware/brightness.nix
              ./hardware/tlp.nix
            ];

          specialArgs = {
            desktop = "hyprland";
            graphics = "intel";
            hdr = false;
            monitors = (import ./monitors).t480;
          };
        };

        Squid = {
          modules =
            default
            ++ sops
            ++ [
              ./aws
              ./wsl
            ];
          specialArgs = {
            desktop = null;
            gitEmail = null;
            gitUser = null;
          };
        };
      };
    in
    {
      nixosConfigurations = nixpkgs.lib.mapAttrs (
        hostname: config:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs =
            inputs
            // defaultUser
            // config.specialArgs
            // {
              inherit hostname;
            }
            // {
              isWsl = nixpkgs.lib.elem ./wsl config.modules;
            };
          modules = config.modules;
        }
      ) mySystems;
    };
}
