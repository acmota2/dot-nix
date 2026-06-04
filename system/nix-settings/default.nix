{
  config,
  isHomeManager,
  lib,
  ...
}:
lib.mkIf (!isHomeManager) (
  let
    username = config.hostSettings.users.default.username;
  in
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
        trusted-users = [
          "root"
          username
        ];
      };
    };
    system.stateVersion = "26.05";

    home-manager.users.${username} = {
      home.stateVersion = "26.05";
      nixpkgs.config.allowUnfree = true;
    };
  }
)
