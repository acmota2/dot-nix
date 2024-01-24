{ pkgs, hostname, ... }:
{
    imports = [
        ./${hostname}.nix
    ];
}
