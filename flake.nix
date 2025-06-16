{
  description = "My machines";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/hyprland";
    };
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
            ./dev
            ./games
            ./hardware/bluetooth.nix
            ./hardware/nfs.nix
            ./multimedia
            ./shell
          ];
          specialArgs = {
            username = "acmota2";
            hostname = "EnderDragon";
            desktop = "hyprland";
            graphics = "amd";
            monitors =
              let
                monitorList = import ./monitors;
                inherit (monitorList) aoc;
              in
              [ aoc ];
          } // inputs;
        };
      };
    };
}
