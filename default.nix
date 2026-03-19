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
        ./desktop
      ];
      base = [
        home-manager.nixosModules.home-manager
        ./apps/terminal/btop
        ./apps/terminal/macchina
        ./apps/terminal/starship
        ./apps/terminal/tmux
        ./dev
        ./dev/languages.nix
        ./system/lix
        ./system/locale
        ./system/nix-settings
        ./system/shell
        ./users
      ];
      machineBase = [
        ./system/boot
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
