{ pkgs, username, ... }:
{
  environment.etc."regreet/background.jpg".source = ../../backgrounds/covao-da-ametade-cold.jpg;

  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.regreet}/bin/regreet";
      user = "greeter";
    };
  };

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

    settings.background = {
      path = "/etc/regreet/background.jpg";
      fit = "fill";
    };
  };
}
