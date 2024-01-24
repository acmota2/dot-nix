{
    description = "Main flake";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";

        home-manager = {
            url = "github:nix-community/home-manager/release-23.11";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nixvim = {
            url = "github:nix-community/nixvim/nixos-23.11";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        hyprland = {
            url = "github:hyprwm/hyprland";
        };
    };

    outputs = { self, nixpkgs, ... }@inputs: {
        nixosConfigurations = {
            "TheLightBeast" = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                modules = [
                    ./.
                    ./dev
                    ./hardware/bluetooth.nix
                    ./hardware/brightness.nix
                    # ./swaylock
                ];
                specialArgs = {
                    username = "acmota2";
                    hostname = "TheLightBeast";
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

