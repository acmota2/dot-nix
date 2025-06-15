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
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    xwayland
    wl-clipboard
    wofi-emoji
  ];

  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
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
      xwayland.enable = true;
    };
    services = {
      hyprpaper.enable = true;
      hypridle.enable = true;
    };
    programs = {
      waybar.enable = true;
      hyprlock.enable = true;
    };
    home = {
      file = {
        # waybar cfg
        ".config/waybar" = {
          source = ./waybar;
          recursive = true;
        };
        # hyrpaper config
        ".config/hypr" = {
          source = ./hypr;
          recursive = true;
        };
        # session start
        # ".zprofile".source = ./.zprofile;
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
