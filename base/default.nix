{ username, ... }: {
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.05";

  home-manager.users.${username} = {
    home.stateVersion = "25.05";
    nixpkgs.config.allowUnfree = true;
  };
}
