{ pkgs, username, ... }:
{
  home-manager.users.${username} = _: {
    home = {
      file.".config/mako/config".source = ./config;
      packages = with pkgs; [ mako ];
    };
  };
}
