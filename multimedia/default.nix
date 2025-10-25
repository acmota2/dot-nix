{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    audacity
    gimp
    muse-sounds-manager
    musescore
  ];
}
