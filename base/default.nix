{ home-manager, pkgs, username, ... }:
{
    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    system.stateVersion = "24.05";

    programs.zsh.enable = true;

    home-manager.users.${username} = {
        home.stateVersion = "24.05";
        nixpkgs.config.allowUnfree = true;
    };
}
