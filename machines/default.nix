{
  config,
  hostname,
  lib,
  pkgs,
  ...
}:
{
  imports = [ ./${hostname}.nix ];
  config = lib.mkIf (!config.hostSettings.meta.isWsl) {
    hardware.firmware = [ pkgs.linux-firmware ];
  };
}
