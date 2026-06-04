{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./amd.nix
    ./bluetooth.nix
    ./brightness.nix
    ./intel.nix
    ./network.nix
    ./nfs.nix
    ./nvidia.nix
    ./sound.nix
    ./tlp.nix
  ];
  config = lib.mkIf (!config.hostSettings.meta.isWsl) {
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
  };
}
