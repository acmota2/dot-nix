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
        ./btop
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
    btop
    coreutils-full
    curl
    file
    git
    macchina
    p7zip
    unzip
    zip
    zsh
  ];
}
