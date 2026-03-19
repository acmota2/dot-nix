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
        ./system/nix-settings
        ./apps/terminal/btop
        ./dev
        ./dev/languages.nix
        ./system/lix
        ./system/locale
        ./apps/terminal/macchina
        ./system/shell
        ./apps/terminal/starship
        ./apps/terminal/tmux
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
