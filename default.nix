{ pkgs, home-manager, desktop, username, hostname, ... }:
{
    imports =
    let
        extraImports = if desktop == "hyprland" then [ ./wofi ./dunst ] else [];
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
        #./nixvim
        ./users
    ] ++ extraImports;

    environment.systemPackages = with pkgs; [
	firefox
        file
        git
        neovim
        wget
        curl
        kitty
        zsh
        discord
        coreutils-full
        macchina
    ];
}
