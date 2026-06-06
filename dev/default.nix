{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [ ./editor.nix ];

  environment.systemPackages = with pkgs; [
    commitizen
    ripgrep
  ];

  programs.nix-ld.enable = config.hostSettings.system.enableNixLd;
}
