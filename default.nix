{ pkgs, home-manager, desktop, username, hostname, ... }:
{
    imports =
    let
        extraImports = if desktop == "hyprland" then [ ./rofi ./dunst ] else [];
    in [
        home-manager.nixosModules.home-manager
        ./base
        ./boot
        ./desktop/${desktop}
        ./kitty
        ./locale
        ./hardware
        ./machines/${hostname}.nix
	    ./multimedia
        ./nixvim
        ./users
    ] ++ extraImports;

    environment.systemPackages = with pkgs; [
        file
        git
        neovim
        wget
        curl
        kitty
        zsh
        brave
        discord
        coreutils-full
        macchina
    ];
}
