{
  description = "My machines";

  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/hyprland";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nixvim.url = "github:nix-community/nixvim";
    sops-nix.url = "github:Mic92/sops-nix";
    unstable.url = "github:NixOS/nixpkgs/nixos-25.11";
    # walker.url = "github:abenz1267/walker";
  };

  outputs =
    {
      home-manager,
      nixpkgs,
      sops-nix,
      ...
    }@inputs:
    let
      defaultUser = {
        gitEmail = "acmota2@gmail.com";
        gitUser = "acmota2";
        shell = "bash";
        username = "acmota2";
      };

      myUtils = import ./utils { lib = nixpkgs.lib; };

      default = [ ./. ];

      machineModules = [
        ./boot/kernel-mod
        ./display-manager/regreet
        ./hardware/nfs.nix
        ./multimedia
        ./virtualization/podman.nix
      ];

      sops = [
        ./sops
        sops-nix.nixosModules.sops
      ];

      system = "x86_64-linux";

      monitors = import ./desktop/hyprland/monitors;

      mySystems = {
        EnderDragon = {
          modules =
            default
            ++ machineModules
            ++ [
              ./games
              ./games/minecraft
              ./hardware/bluetooth.nix
              ./multimedia/video.nix
            ];

          specialArgs = {
            desktop = "hyprland";
            graphics = "amd";
            hdr = true;
            monitors = [
              monitors.aoc
              monitors.portable
            ];
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
            monitors = [
              monitors.t480
              monitors.aoc-t480
              monitors.acer
            ];
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
      homeConfigurations = {
        "acmota2" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = [
            ./aws
            ./home
            ./macchina
            ./nixvim
            ./shell
            ./starship
            ./users
          ];
          extraSpecialArgs =
            defaultUser
            // inputs
            // {
              inherit myUtils;
              isHomeManager = true;
            };
        };
      };
      nixosConfigurations = nixpkgs.lib.mapAttrs (
        hostname: config:
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = config.modules;
          specialArgs =
            inputs
            // defaultUser
            // config.specialArgs
            // {
              inherit hostname myUtils;
              isWsl = nixpkgs.lib.elem ./wsl config.modules;
              isHomeManager = false;
            };
        }
      ) mySystems;
    };
}
