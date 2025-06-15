{ pkgs, home-manager, desktop, ... }:
{
  imports = [
    home-manager.nixosModules.home-manager
    ./base
    ./boot
    ./desktop/${desktop}
    ./dev
    ./dev/languages.nix
    ./foot
    ./hardware
    ./locale
    ./macchina
    ./machines
    ./mako
    ./multimedia
    ./nixvim
    ./starship
    ./tmux
    ./users
    ./wofi
  ];

  environment.systemPackages = with pkgs; [
    file
    git
    wget
    curl
    zsh
    firefox
    discord
    coreutils-full
    killall
    macchina
    zoxide
    starship
    htop
  ];
}
