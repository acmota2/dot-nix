{ home-manager, pkgs, username, ... }:
{
    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    system.stateVersion = "23.11";

    programs.zsh.enable = true;

    home-manager.users.${username} = {
        home.stateVersion = "23.11";
        nixpkgs.config.allowUnfree = true;
    };
}
