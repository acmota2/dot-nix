{
  pkgs,
  hyprland,
  username,
  ...
}@inputs:
{
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-emoji
    jetbrains-mono
    font-awesome
    nerd-fonts.jetbrains-mono
  ];

  environment.systemPackages = with pkgs; [
    cliphist
    grimblast
    hyprpaper
    hypridle
    xwayland
    wl-clipboard
    wofi-emoji
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
  ];

  services.dbus.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
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
      ./binds.nix
      ./rules.nix
    ];

    wayland.windowManager.hyprland = {
      enable = true;
      package = null;
      portalPackage = null;
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
      waybar.enable = true;
      hyprlock = {
        enable = true;
        settings = import ./hyprlock;
      };
    };

    home = {
      file = {
        # waybar cfg
        ".config/waybar" = {
          source = ./waybar;
          recursive = true;
        };
        # session start
        ".zprofile".source = ./.zprofile;
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

    gtk = {
      enable = true;
      theme = {
        package = pkgs.adwaita-qt6;
        name = "Adwaita:dark";
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
  };
}
