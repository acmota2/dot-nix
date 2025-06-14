{ pkgs, home-manager, desktop, username, hostname, ... }:
{
    imports = [
        home-manager.nixosModules.home-manager
        ./base
        ./boot
        ./desktop/${desktop}
        ./kitty
        ./locale
	./machines
        ./hardware
  	./multimedia
        ./nixvim
        ./users
        ./wofi
	./mako
    ];

    environment.systemPackages = with pkgs; [
        file
        git
        neovim
        wget
        curl
        kitty
        zsh
        firefox
        discord
        coreutils-full
        macchina
    ];
}
