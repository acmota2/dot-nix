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
    unstable.url = "github:NixOS/nixpkgs/nixos-25.11";
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

      defaultUser = {
        gitEmail = "acmota2@gmail.com";
        gitUser = "acmota2";
        shell = "bash";
        username = "acmota2";
      };

      myUtils = import ./utils { inherit lib; };
      dot-nvim = dot-nix-neovim.packages.${system}.default;
      monitors = import ./desktop/monitors;

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

      specialArgs = {
        EnderDragon = {
          desktop = "hyprland";
          graphics = "amd";
          hdr = true;
          isMultiMonitor = true;
          monitors = [
            monitors.aoc
            monitors.portable
          ];
        };
        Allay = {
          desktop = "mangowc";
          graphics = "intel";
          hdr = false;
          monitors = [
            monitors.t480
            monitors.aoc
          ];
        };
      };

      mySystems = {
        EnderDragon = {
          modules =
            default
            ++ machineModules
            ++ [
              ./apps/games
              ./apps/games/minecraft
              ./apps/llm
              ./apps/multimedia
              ./apps/multimedia/audio
              ./apps/multimedia/audio/extra.nix
              ./apps/multimedia/video.nix
              ./display-manager/ly
              ./hardware/bluetooth.nix
            ];
        };

        Allay = {
          modules =
            default
            ++ machineModules
            ++ sops
            ++ [
              ./apps/games
              ./apps/games/minecraft
              ./apps/multimedia
              ./apps/multimedia/audio
              ./display-manager/ly
              ./hardware/bluetooth.nix
              ./hardware/brightness.nix
              ./hardware/tlp.nix
            ];
        };
      };

      mkSpecialArgs =
        hostname: config:
        inputs
        // defaultUser
        // specialArgs.${hostname}
        // {
          inherit hostname myUtils dot-nvim;
          isWsl = lib.elem ./wsl config.modules;
          isHomeManager = false;
          unstable = import unstable {
            inherit system;
            config.allowUnfree = true;
          };
        };

      mkNixosSystem =
        hostname: config:
        lib.nixosSystem {
          inherit system;
          modules = config.modules;
          specialArgs = mkSpecialArgs hostname config;
        };
    in
    {
      devShells.${system}.default = nixpkgs.legacyPackages.${system}.mkShell {
        packages = with nixpkgs.legacyPackages.${system}; [
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
          extraSpecialArgs =
            defaultUser
            // inputs
            // {
              inherit myUtils dot-nvim;
              isHomeManager = true;
            };
        };
      };

      nixosConfigurations = lib.mapAttrs mkNixosSystem mySystems;
    };
}
