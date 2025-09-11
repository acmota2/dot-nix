{
  pkgs,
  home-manager,
  desktop,
  isWsl,
  ...
}:
{
  imports =
    let
      guiPackages = [
        ./desktop
        ./desktop/${desktop}
      ];
      base = [
        home-manager.nixosModules.home-manager
        ./base
        ./dev
        ./dev/languages.nix
        ./locale
        ./macchina
        ./nixvim
        ./shell
        ./starship
        ./tmux
        ./users
      ];
      machineBase = [
        ./boot
        ./hardware
        ./machines
      ];
      defaults = if isWsl then base else base ++ machineBase;
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
    p7zip
    unzip
    wget
    zip
    zsh
  ];
}
