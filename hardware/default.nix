{ graphics, pkgs, ... }:
{
  imports = [
    ./sound.nix
    ./network.nix
    ./${graphics}.nix
  ];
  hardware.keyboard.qmk.enable = true;
  environment.systemPackages = with pkgs; [
    qmk
    qmk-udev-rules
    vial
  ];
  services = {
    udev.packages = with pkgs; [
      qmk
      qmk-udev-rules
      vial
    ];
    udisks2 = {
      enable = true;
      mountOnMedia = true;
    };
  };
}
