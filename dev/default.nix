{
  config,
  lib,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    commitizen
    ripgrep
  ];

  programs.nix-ld.enable = lib.mkIf config.hostSettings.system.enableNixLd true;
}
