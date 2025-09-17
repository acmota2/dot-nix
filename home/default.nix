{ username, ... }:
{
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "25.05";
  home.sessionVariables.EDITOR = "nvim";

  programs.home-manager.enable = true;
}
