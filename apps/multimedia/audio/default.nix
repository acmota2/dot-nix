{ pkgs, unstable, ... }:
{
  environment.systemPackages = with pkgs; [
    audacity
    crosspipe
    unstable.musescore
  ];
}
