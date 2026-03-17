{
  description = "My machines";

  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/hyprland";
    mango = {
      url = "github:mangowm/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nixvim.url = "github:nix-community/nixvim";
    dot-nix-neovim.url = "github:acmota2/dot-nix-neovim";
    sops-nix.url = "github:Mic92/sops-nix";
    unstable.url = "github:NixOS/nixpkgs/nixos-25.11";
    # walker.url = "github:abenz1267/walker";
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
        ./display-manager/ly
        ./hardware/nfs.nix
        ./multimedia
        ./virtualization/podman.nix
      ];

      sops = [
        ./sops
        sops-nix.nixosModules.sops
      ];

      system = "x86_64-linux";

      dot-nvim = dot-nix-neovim.packages.${system}.default;

      monitors = import ./desktop/tiling/monitors;

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
            desktop = "mangowc";
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
              monitors.aoc
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
              inherit hostname myUtils dot-nvim;
              isWsl = nixpkgs.lib.elem ./wsl config.modules;
              isHomeManager = false;
              unstable = unstable.legacyPackages.${system};
            };
        }
      ) mySystems;
    };
}
