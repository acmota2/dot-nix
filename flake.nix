{
  description = "My machines";

  inputs = {
    disko.url = "github:nix-community/disko";
    elephant.url = "github:abenz1267/elephant";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    mango = {
      url = "github:mangowm/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    musnix.url = "github:musnix/musnix";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nixvim.url = "github:nix-community/nixvim";
    my-nixvim.url = "github:acmota2/dot-nix-neovim";
    sops-nix.url = "github:Mic92/sops-nix";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    walker = {
      url = "github:abenz1267/walker";
      inputs.elephant.follows = "elephant";
    };
  };

  outputs =
    {
      home-manager,
      nixpkgs,
      sops-nix,
      unstable,
      walker,
      ...
    }@inputs:
    let
      inherit (nixpkgs) lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      unstablePkgs = import unstable {
        inherit system;
        config.allowUnfree = true;
      };

      monitors = import ./desktop/monitors;
      default = [
        ./.
        ./modules/flake-module-configuration.nix
      ];

      machineModules = [
        ./apps/multimedia
        ./dev/virtualization/podman.nix
        ./display-manager/ly
        ./hardware/nfs.nix
        ./home
      ];

      sops = [
        ./sops
        sops-nix.nixosModules.sops
      ];

      mySystems = {
        EnderDragon = {
          modules = default ++ machineModules ++ sops;
          specialArgs = {
            isHomeManager = false;
            monitors = {
              primary = monitors.aoc;
              other = [ monitors.portable ];
            };
          };
        };
        Allay = {
          modules = default ++ machineModules ++ sops;
          specialArgs = {
            isHomeManager = false;
            monitors = {
              primary = monitors.t480;
              other = [ monitors.aoc ];
            };
          };
        };
      };

      mkSpecialArgs =
        hostname: config:
        inputs
        // config.specialArgs
        // {
          inherit hostname walker;
          unstable = unstablePkgs;
          meta.utils = import ./utils { inherit lib; };
        };

      mkNixosSystem =
        hostname: config:
        lib.nixosSystem {
          inherit system;
          modules = config.modules ++ [ ./hosts ];
          specialArgs = mkSpecialArgs hostname config;
        };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          age
          just
          ssh-to-age
          sops
        ];
      };

      homeConfigurations = {
        acmota2 = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = [
            ./apps/terminal/macchina
            ./apps/terminal/starship
            ./home
            ./system/shell
            ./users
          ];
          extraSpecialArgs = inputs // {
            inherit unstable;
          };
        };
      };

      nixosConfigurations = lib.mapAttrs mkNixosSystem mySystems;
    };
}
