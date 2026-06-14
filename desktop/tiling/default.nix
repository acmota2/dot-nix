{
  config,
  lib,
  meta,
  monitors,
  pkgs,
  ...
}@inputs:
let
  desktop = config.hostSettings.display.desktop.name;
  actualMonitors = [ monitors.primary ] ++ (monitors.other or [ ]);
  inputsWithMonitors = inputs // {
    inherit actualMonitors;
  };
in
{
  imports = [
    ../foot
    (import ./hyprland inputsWithMonitors)
    ./mako
    (import ./mangowc inputsWithMonitors)
    (import ./niri inputsWithMonitors)
    ./walker
  ];

  config = lib.mkIf (meta.utils.isTiling desktop) {
    nix.settings = {
      extra-substituters = [ "https://walker.cachix.org" ];
      extra-trusted-public-keys = [ "walker.cachix.org-1:fG8q+uAaMqhsMxWjwvk0IMb4mFPFLqHjuvfwQxE4oJM=" ];
    };

    environment.systemPackages = [
      pkgs.brave
      pkgs.cliphist
      pkgs.discord
      pkgs.wl-clipboard
    ];

    home-manager.users.${config.hostSettings.users.default.username} = _: {
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
        settings = import ./waybar inputs;
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
  };
}
