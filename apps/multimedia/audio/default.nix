{ pkgs, unstable, ... }:
{
  environment.systemPackages = with pkgs; [
    audacity
    helvum
    unstable.musescore
  ];
}
