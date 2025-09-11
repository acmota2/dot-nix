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
    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
    in
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
            ./sops
            sops-nix.nixosModules.sops

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
          }
          // inputs
          // defaultUser;
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
            ./sops
            sops-nix.nixosModules.sops
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
          // inputs
          // defaultUser;
        };
        "Squid" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./.
            ./sops
            ./wsl
            sops-nix.nixosModules.sops
          ];
          specialArgs = {
            desktop = null;
            gitEmail = "acmota2@gmail.com";
            gitUser = "acmota2";
            hostname = "Squid";
            isWsl = true;
            username = "acmota2";
          }
          // inputs;
        };
      };
    };
}
