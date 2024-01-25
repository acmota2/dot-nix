{ pkgs, ... }:
{
    imports = [
        ./minecraft
    ];  
    environment.systemPackages = with pkgs; [
        steam
        lutris
    ];
}

