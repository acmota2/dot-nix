{
    description = "My machines";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
        unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

        home-manager = {
            url = "github:nix-community/home-manager/release-24.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nixvim = {
            url = "github:nix-community/nixvim/nixos-24.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        hyprland = {
            url = "github:hyprwm/hyprland";
        };
    };

    outputs = { self, nixpkgs, ... }@inputs: {
        nixosConfigurations = {
            "Imp" = nixpkgs.lib.nixosSystem {
                system = "x86_64";
                modules = [
                    ./.
                    #./dev
                    ./games/minecraft
                    ./hardware/bluetooth.nix
                    ./hardware/brightness.nix
                    # ./swaylock
                ];
                specialArgs = {
                    username = "acmota2";
                    hostname = "Imp";
                    desktop = "hyprland";
                    isPotato = true;
                    nvidia = false;
                } // inputs;
            };
            "TheChonkyBeast" = nixpkgs.lib.nixosSystem {
                system = "x86_64";
                modules = [
                    ./.
                    ./dev
                    ./games
                    ./hardware/bluetooth.nix
                    ./hardware/brightness.nix
                    # ./swaylock
                ];
                specialArgs = {
                    username = "acmota2";
                    hostname = "TheChonkyBeast";
                    desktop = "hyprland";
                    isPotato = false;
                    nvidia = true;
                } // inputs;
            };
        };
    };
}

