{ pkgs, username, ... }:
{
  programs.regreet = {
    enable = true;
    font = {
      name = "JetBrains Mono";
      size = 12;
    };
    theme.name = "Adwaita-dark";
    cursorTheme = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
    };
    settings = {
      background = {
        path = "/home/${username}/pictures/covao da ametade cold.jpg";
        fit = "fill";
      };
      widget.clock = {
        format = "%H:%M";
        timezone = "Europe/Berlin";
      };
    };
  };
}
