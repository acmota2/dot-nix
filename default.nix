{
  dot-nvim,
  home-manager,
  pkgs,
  ...
}:
{
  imports = [
    home-manager.nixosModules.home-manager
    ./desktop
    ./display-manager/ly
    ./hardware
    ./machines
    ./system/boot
    ./system/lix
    ./system/locale
    ./system/nix-settings
    ./users
  ];

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
  ];
}
