{
  config,
  lib,
  pkgs,
  ...
}:
lib.mkIf config.hostSettings.hardware.isLaptop {
  environment.systemPackages = with pkgs; [ brightnessctl ];
}
