{
  pkgs,
  desktop,
  username,
  ...
}@inputs:
{
  imports = [
    ./${desktop}
    ../foot
    # ./walker
    ./wofi
    ./mako
  ];

  environment.systemPackages = [
    pkgs.brave
    pkgs.cliphist
    pkgs.discord
    pkgs.wl-clipboard
    pkgs.wofi-emoji
    pkgs.wofi-power-menu
  ];

  home-manager.users.${username} = _: {
    home = {
      file."pictures/" = {
        source = ../../backgrounds;
        recursive = true;
      };

      pointerCursor = {
        gtk.enable = true;
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Ice";
        size = 24;
      };

      sessionVariables = {
        NIXOS_OZONE_WL = "1";
        GTK_THEME = "Adwaita-dark";
      };
    };

    programs.waybar = {
      enable = true;
      settings = import ./waybar/${desktop}${
        if inputs.isMultiMonitor or false then "-multi-monitor" else ""
      }.nix;
      style = builtins.readFile ./waybar/style.css;
    };

    dconf.settings."org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-application-prefer-dark-theme = true;
    };

    gtk = {
      enable = true;
      theme = {
        name = "Adwaita-dark";
        package = pkgs.gnome-themes-extra;
      };
      iconTheme = {
        package = pkgs.adwaita-icon-theme;
        name = "Adwaita";
      };

      font = {
        package = pkgs.source-sans;
        name = "SouceSans3";
        size = 11;
      };
    };

    qt = {
      enable = true;
      platformTheme.name = "gtk";
      style.name = "adwaita-dark";
      style.package = pkgs.adwaita-qt6;
    };
  };
}
