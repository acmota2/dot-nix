{ pkgs, isPotato, ... }:
{
    environment.systemPackages = with pkgs; let
        minecraft = [ atlauncher ];
    in if isPotato then
        minecraft
    else
        minecraft ++ [
            steam
            lutris
        ];
}

