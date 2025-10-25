{ hostname, pkgs, ... }:
{
  imports = [ ./${hostname}.nix ];
  hardware.firmware = [ pkgs.linux-firmware ];
}
