{ pkgs, username, ... }:
{
    environment.systemPackages = with pkgs; [
        # Haskell
        stack
        cargo
        libgcc
        gdb
        go
        python3
        elixir
        nodePackages.npm
        nodejs_22
        docker
        jdk21
        jdk17
        jdk8
    ];
    users.users."${username}".extraGroups = [ "docker" ];
}
