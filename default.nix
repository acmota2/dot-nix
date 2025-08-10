{
  pkgs,
  home-manager,
  desktop,
  ...
}:
{
  imports =
    let
      guiPackages = [
        ./desktop
        ./desktop/${desktop}
      ];
      defaults = [
        home-manager.nixosModules.home-manager
        ./base
        ./boot
        ./desktop/${desktop}
        ./dev
        ./dev/languages.nix
        ./hardware
        ./locale
        ./macchina
        ./machines
        ./nixvim
        ./starship
        ./tmux
        ./users
      ];
    in
    if desktop != null then defaults ++ guiPackages else defaults;

  environment.systemPackages = with pkgs; [
    coreutils-full
    curl
    file
    git
    htop
    killall
    macchina
    unzip
    wget
    zip
    zsh
  ];
}
