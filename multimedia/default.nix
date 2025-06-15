{ pkgs, ... }: { environment.systemPackages = with pkgs; [ gimp musescore ]; }
