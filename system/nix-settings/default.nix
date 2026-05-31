{ username, ... }:
{
  nixpkgs.config.allowUnfree = true;
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [ username ];
    };
  };
  system.stateVersion = "26.05";

  home-manager.users.${username} = {
    home.stateVersion = "26.05";
    nixpkgs.config.allowUnfree = true;
  };
}
