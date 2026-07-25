{ pkgs, unstable, ... }:
{
  environment.systemPackages = with pkgs; [
    audacity
    alsa-scarlett-gui
    crosspipe
    strawberry
    unstable.musescore
  ];
}
