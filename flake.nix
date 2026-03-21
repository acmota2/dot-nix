{
  description = "My machines";

  inputs = {
    disko.url = "github:nix-community/disko";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # hyprland.url = "github:hyprwm/hyprland";
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
        ./apps/multimedia
        ./hardware/nfs.nix
        ./system/boot/kernel-mod
        ./dev/virtualization/podman.nix
      ];

      sops = [
        ./sops
        sops-nix.nixosModules.sops
      ];

      system = "x86_64-linux";

      dot-nvim = dot-nix-neovim.packages.${system}.default;

      monitors = import ./desktop/monitors;

      mySystems = {
        EnderDragon = {
          modules =
            default
            ++ machineModules
            ++ [
              ./apps/games
              ./apps/games/minecraft
              ./apps/multimedia/video.nix
              ./display-manager/ly
              ./hardware/bluetooth.nix
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
              ./apps/games
              ./display-manager/ly
              ./hardware/bluetooth.nix
              ./hardware/brightness.nix
              ./hardware/tlp.nix
            ];

          specialArgs = {
            desktop = "mangowc";
            graphics = "intel";
            hdr = false;
            monitors = [
              monitors.t480
              monitors.aoc
            ];
          };
        };

        Wither = {
          modules =
            default
            ++ machineModules
            ++ sops
            ++ [
              ./apps/appimage
              ./apps/games
              ./apps/games/minecraft
              ./hardware/bluetooth.nix
              ./system/disko/Wither.nix
              ./users/autologin.nix
            ];
          specialArgs = {
            desktop = "gamescope";
            graphics = "amd";
            hdr = false;
          };
        };
      };
    in
    {
      homeConfigurations = {
        "acmota2" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = [
            ./apps/terminal/macchina
            ./apps/terminal/starship
            ./home
            ./system/shell
            ./users
          ];
          extraSpecialArgs =
            defaultUser
            // inputs
            // {
              inherit myUtils dot-nvim;
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
