{
  pkgs,
  hyprland,
  username,
  ...
}@inputs:
{
  fonts.packages = with pkgs; [
    font-awesome
    jetbrains-mono
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-color-emoji
  ];

  environment.systemPackages = with pkgs; [
    cliphist
    hypridle
    hyprpaper
    hyprshot
    wl-clipboard
    wofi-emoji
    wofi-power-menu
  ];

  services.dbus.enable = true;

  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    withUWSM = true;
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  home-manager.users.${username} = _: {
    imports = [
      hyprland.homeManagerModules.default
      (import ./settings.nix inputs)
      (import ./binds.nix inputs)
      ./rules.nix
    ];

    wayland.windowManager.hyprland = {
      enable = true;
      package = null;
      portalPackage = null;
      systemd.variables = [ "--all" ];
    };

    home.file."pictures/" = {
      source = ../../backgrounds;
      recursive = true;
    };

    services = {
      hyprpaper = {
        enable = true;
        settings = import ./hyprpaper;
      };
      hypridle = {
        enable = true;
        settings = import ./hypridle;
      };
    };

    programs = {
      waybar = {
        enable = true;
        settings = import ./waybar;
        style = builtins.readFile ./waybar/style.css;
      };
      hyprlock = {
        enable = true;
        settings = import ./hyprlock;
      };
    };

    home = {
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
