{
  isGaming ? false,
  monitors,
  pkgs,
  username,
  ...
}@inputs:
let
  renderMonitor =
    m:
    "name:^${m.output}$,width:${toString m.width},height:${toString m.height},refresh:${toString m.refresh},x:${toString m.x},y:${toString m.y},scale:${toString m.scale},vrr:${toString m.vrr},rr:${toString m.rotate}";

  mangoSettings = (if isGaming then import ./settings-minimal.nix else import ./settings.nix) {
    inherit monitors renderMonitor;
  };

  autostartScript = import ./autostart.nix { inherit pkgs monitors isGaming; };
in
{
  imports = [ inputs.mango.nixosModules.mango ];

  environment.systemPackages =
    with pkgs;
    [
      swayidle
      swaylock-effects
      sway-audio-idle-inhibit
    ]
    ++ (
      if isGaming then
        [ ]
      else
        [
          grim
          slurp
          swayosd
        ]
    );

  # Fix SwayOSD crash on suspend
  systemd.user.services.swayosd = {
    description = "SwayOSD display service";
    partOf = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.swayosd}/bin/swayosd-server";
      Restart = "always";
      RestartSec = "2sec";
    };
    wantedBy = [ "graphical-session.target" ];
  };

  programs.mango.enable = true;
  security.pam.services.swaylock = { };
  services.dbus.enable = true;

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  home-manager.users.${username} = _: {
    imports = [ inputs.mango.hmModules.mango ];

    home.file.".config/swaylock/config".source = ./swaylock.conf;

    wayland.windowManager.mango = {
      enable = true;
      settings = mangoSettings;
      autostart_sh = "${autostartScript}";
    };
  };
}
