{
  description = "My machines";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/hyprland";
  };

  outputs =
    { nixpkgs, ... }@inputs:
    {
      nixosConfigurations = {
        "EnderDragon" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./.
            ./boot/kernel-mod
            ./games
            ./games/minecraft
            ./hardware/bluetooth.nix
            ./hardware/nfs.nix
            ./multimedia
          ];
          specialArgs = {
            desktop = "hyprland";
            graphics = "amd";
            hdr = true;
            hostname = "EnderDragon";
            isWsl = false;
            monitors =
              let
                monitorList = import ./monitors;
                inherit (monitorList) aoc;
              in
              [ aoc ];
            userEmail = "acmota2@gmail.com";
            username = "acmota2";
          }
          // inputs;
        };
        "Allay" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./.
            ./boot/kernel-mod
            ./games
            ./hardware/bluetooth.nix
            ./hardware/brightness.nix
            ./hardware/nfs.nix
            ./hardware/tlp.nix
            ./multimedia
          ];
          specialArgs = {
            desktop = "hyprland";
            graphics = "intel";
            hdr = false;
            hostname = "Allay";
            isWsl = false;
            monitors =
              let
                monitorList = import ./monitors;
                inherit (monitorList) t480;
              in
              [ t480 ];
            userEmail = "acmota2@gmail.com";
            username = "acmota2";
          }
          // inputs;
        };
        "Squid" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./.
            ./wsl
          ];
          specialArgs = {
            desktop = null;
            hostname = "Squid";
            isWsl = true;
            userEmail = "acmota2@gmail.com";
            username = "acmota2";
          }
          // inputs;
        };
      };
    };
}
