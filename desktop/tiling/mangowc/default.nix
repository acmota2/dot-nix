{
  config,
  lib,
  mango,
  monitors,
  pkgs,
  ...
}@inputs:
{
  imports = [ mango.nixosModules.mango ];

  config = lib.mkIf (config.hostSettings.display.desktop.name == "mangowc") (
    let
      renderMonitor =
        m:
        builtins.concatStringsSep "," [
          "name:^${m.output}$"
          "width:${toString m.width}"
          "height:${toString m.height}"
          "refresh:${toString m.refresh}"
          "x:${toString m.x}"
          "y:${toString m.y}"
          "scale:${toString m.scale}"
          "vrr:${toString m.vrr}"
          "rr:${toString m.rotate}"
        ];

      mangoSettings = (import ./settings.nix) {
        inherit monitors renderMonitor;
      };

      autostartScript = import ./autostart.nix {
        inherit pkgs monitors;
      };
    in
    {

      environment.systemPackages = with pkgs; [
        swayidle
        swaylock-effects
        sway-audio-idle-inhibit
        grim
        slurp
        swayosd
      ];

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

      home-manager.users.${config.hostSettings.users.default.username} = _: {
        imports = [ inputs.mango.hmModules.mango ];

        home.file.".config/swaylock/config".source = ./swaylock.conf;

        wayland.windowManager.mango = {
          enable = true;
          settings = mangoSettings;
          autostart_sh = "${autostartScript}";
          systemd = {
            enable = true;
            variables = [
              "DISPLAY"
              "WAYLAND_DISPLAY"
              "XDG_CURRENT_DESKTOP"
              "XDG_SESSION_TYPE"
            ];
            extraCommands = [
              "systemctl --user reset-failed"
              "systemctl --user start mango-session.target"
            ];
            xdgAutostart = true;
          };
        };
      };
    }
  );
}
