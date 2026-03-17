{
  pkgs,
  hyprland,
  username,
  ...
}@inputs:
{
  environment.systemPackages = [
    pkgs.hypridle
    pkgs.hyprpaper
    pkgs.hyprshot
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
      systemd.enable = false;
      # systemd.variables = [ "--all" ];
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

    programs.hyprlock = {
      enable = true;
      settings = import ./hyprlock;
    };
  };
}
