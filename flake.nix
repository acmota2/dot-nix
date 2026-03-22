{
  description = "My machines";

  inputs = {
    colmena = {
      url = "github:zhaofengli/colmena/main";
      inputs.nixpkgs.follows = "unstable";
    };
    disko.url = "github:nix-community/disko";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mango = {
      url = "github:mangowm/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixos-anywhere.url = "github:nix-community/nixos-anywhere";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nixvim.url = "github:nix-community/nixvim";
    dot-nix-neovim.url = "github:acmota2/dot-nix-neovim";
    sops-nix.url = "github:Mic92/sops-nix";
    unstable.url = "github:NixOS/nixpkgs/nixos-25.11";
  };

  outputs =
    {
      colmena,
      dot-nix-neovim,
      home-manager,
      nixos-anywhere,
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
            isGaming = false;
            monitors = [
              monitors.aoc
              monitors.portable
            ];
          };

          deployment = {
            targetHost = "enderdragon";
            targetUser = "acmota2";
            buildOnTarget = true;
            tags = [
              "desktop"
              "personal"
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
            isGaming = false;
            monitors = [
              monitors.t480
              monitors.aoc
            ];
          };

          deployment = {
            targetHost = "allay";
            targetUser = "acmota2";
            buildOnTarget = true;
            tags = [
              "laptop"
              "personal"
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
              ./apps/games/emulation
              ./apps/games/minecraft
              ./apps/terminal/ssh
              ./display-manager/ly
              ./hardware/bluetooth.nix
              ./system/disko/Wither.nix
              ./system/systemd/faster-boot.nix
              ./users/autologin.nix
              ./users/root/enable-ssh.nix
            ];

          specialArgs = {
            desktop = "mangowc";
            graphics = "amd";
            hdr = false;
            isGaming = true;
            monitors = [
              monitors.tv
            ];
          };

          deployment = {
            targetHost = "192.168.178.82";
            targetUser = "root";
            buildOnTarget = true;
            tags = [
              "console"
              "personal"
            ];
          };
        };
      };

      mkSpecialArgs =
        hostname: config:
        inputs
        // defaultUser
        // config.specialArgs
        // {
          inherit hostname myUtils dot-nvim;
          isWsl = lib.elem ./wsl config.modules;
          isHomeManager = false;
          unstable = unstable.legacyPackages.${system};
        };

      mkNixosSystem =
        hostname: config:
        lib.nixosSystem {
          inherit system;
          modules = config.modules;
          specialArgs = mkSpecialArgs hostname config;
        };

      mkColmenaNode = hostname: config: {
        imports = config.modules;

        deployment = {
          targetHost = config.deployment.targetHost;
          targetUser = config.deployment.targetUser;
          buildOnTarget = config.deployment.buildOnTarget or true;
          tags = config.deployment.tags or [ ];
          privilegeEscalationCommand = [
            "sudo"
            "-H"
            "--"
          ];
        };
      };

    in
    {
      colmenaHive = colmena.lib.makeHive (
        {
          meta = {
            nixpkgs = import nixpkgs { inherit system; };
            specialArgs = inputs;
            nodeSpecialArgs = lib.mapAttrs mkSpecialArgs mySystems;
          };
        }
        // lib.mapAttrs mkColmenaNode mySystems
      );

      devShells.${system}.default = nixpkgs.legacyPackages.${system}.mkShell {
        packages = with nixpkgs.legacyPackages.${system}; [
          age
          colmena.packages.${system}.colmena
          just
          nixos-anywhere.packages.${system}.default
          ssh-to-age
          sops
        ];
      };

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

      nixosConfigurations = lib.mapAttrs mkNixosSystem mySystems;
    };
}
