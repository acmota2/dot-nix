{ pkgs, home-manager, desktop, username, hostname, ... }:
{
    imports = [
        home-manager.nixosModules.home-manager
        ./base
        ./boot
        ./desktop/${desktop}
	./foot
        ./hardware
        ./locale
	./macchina
	./machines
	./mako
  	./multimedia
        ./nixvim
	./starship
        ./users
        ./wofi
    ];

    environment.systemPackages = with pkgs; [
        file
        git
        wget
        curl
        kitty
        zsh
        firefox
        discord
        coreutils-full
        macchina
	zoxide
	starship
    ];
}
