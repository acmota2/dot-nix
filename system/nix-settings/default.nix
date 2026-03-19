{ username, ... }:
{
  nixpkgs.config.allowUnfree = true;
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
  system.stateVersion = "25.11";

  home-manager.users.${username} = {
    home.stateVersion = "25.11";
    nixpkgs.config.allowUnfree = true;
  };
}
