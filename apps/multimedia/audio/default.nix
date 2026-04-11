{ pkgs, unstable, ... }:
{
  environment.systemPackages = with pkgs; [
    audacity
    unstable.musescore
  ];
}
