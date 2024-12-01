{ pkgs, unstable, ... }:
{
    programs.java.enable = true;
    environment.systemPackages = with unstable.legacyPackages."${pkgs.system}"; [
        atlauncher
    ];
}
