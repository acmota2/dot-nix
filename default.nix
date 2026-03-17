{
  desktop,
  dot-nvim,
  home-manager,
  isWsl,
  pkgs,
  ...
}:
{
  imports =
    let
      guiPackages = [
        ./desktop/tiling
      ];
      base = [
        home-manager.nixosModules.home-manager
        ./base
        ./btop
        ./dev
        ./dev/languages.nix
        ./lix
        ./locale
        ./macchina
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
    deluge
    dot-nvim
    file
    git
    macchina
    p7zip
    unzip
    zip
    zsh
  ];
}
