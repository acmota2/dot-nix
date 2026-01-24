{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    audacity
    gimp
    inkscape
    muse-sounds-manager
    musescore
    vlc
  ];
}
