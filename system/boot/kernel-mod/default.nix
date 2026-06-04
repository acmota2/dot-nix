{
  config,
  lib,
  pkgs,
  ...
}:
lib.mkIf config.hostSettings.hardware.enableRollingKernel {
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
