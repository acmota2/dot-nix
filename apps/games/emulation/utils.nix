{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ps3iso-utils
    ps3-disc-dumper
  ];
}
