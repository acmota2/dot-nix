{
  pkgs,
  desktop,
  username,
  ...
}:
{
  imports = [
    ./${desktop}
    ../foot
    # ./walker
    ./wofi
    ./mako
  ];

  programs = {
    chromium = {
      enable = true;
      extensions = [
        "E37DB9C9AF23577974200276678C5E465E26C44B" # ublock origin
      ];
    };
    dconf.enable = true;
    ydotool.enable = true;
  };

  fonts.packages = [
    pkgs.font-awesome
    pkgs.jetbrains-mono
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.noto-fonts
    pkgs.noto-fonts-color-emoji
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
        "NIXOS_OZONE_WL" = "1";
      };
    };

    programs.waybar = {
      enable = true;
      settings = import ./waybar/${desktop}.nix;
      style = builtins.readFile ./waybar/style.css;
    };

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
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
