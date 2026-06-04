{
  description = "My machines";

  inputs = {
    disko.url = "github:nix-community/disko";
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
    dot-nix-neovim.url = "github:acmota2/dot-nix-neovim";
    sops-nix.url = "github:Mic92/sops-nix";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    {
      dot-nix-neovim,
      home-manager,
      nixpkgs,
      sops-nix,
      unstable,
      ...
    }@inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      unstablePkgs = import unstable {
        inherit system;
        config.allowUnfree = true;
      };

      dot-nvim = dot-nix-neovim.packages.${system}.default;
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
            monitors = [
              monitors.aoc
              monitors.portable
            ];
          };
        };
        Allay = {
          modules = default ++ machineModules ++ sops;
          specialArgs = {
            isHomeManager = false;
            monitors = [
              monitors.t480
              monitors.aoc
            ];
          };
        };
      };

      mkSpecialArgs =
        hostname: config:
        inputs
        // config.specialArgs
        // {
          inherit dot-nvim hostname;
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
            inherit dot-nvim unstable;
          };
        };
      };

      nixosConfigurations = lib.mapAttrs mkNixosSystem mySystems;
    };
}
