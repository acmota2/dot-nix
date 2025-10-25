{ username, ... }:
{
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "25.05"; # Update this when changing nixpkgs version
  home.sessionVariables.EDITOR = "nvim";

  programs.home-manager.enable = true;
}
