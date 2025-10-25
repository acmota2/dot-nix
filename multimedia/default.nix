{ pkgs, stable, ... }:
let
  system = pkgs.stdenv.hostPlatform.system;
  pkgs-stable = stable.legacyPackages.${system};
in
{
  environment.systemPackages = [
    pkgs.audacity
    pkgs.gimp
    pkgs.muse-sounds-manager
    pkgs-stable.musescore
  ];
}
