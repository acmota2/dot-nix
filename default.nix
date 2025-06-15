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
        ./foot
        home-manager.nixosModules.home-manager
      ];
      defaults = [
        ./base
        ./boot
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
    file
    git
    wget
    curl
    zsh
    coreutils-full
    killall
    macchina
    htop
  ];
}
