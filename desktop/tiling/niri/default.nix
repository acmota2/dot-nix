{
  actualMonitors,
  config,
  lib,
  pkgs,
  ...
}:
lib.mkIf (config.hostSettings.display.desktop.name == "niri") (
  let
    vrr-parse =
      vrr:
      {
        "0" = "";
        "1" = "variable-refresh-rate";
      }
      .${toString vrr} or "variable-refresh-rate on-demand=true";
  in
  {
    programs.niri.enable = true;

    environment.systemPackages = with pkgs; [
      swaybg
      swayidle
      swaylock-effects
      xwayland-satellite
    ];

    security.pam.services.noctalia-lock = { };

    home-manager.users.${config.hostSettings.users.default.username} = _: {
      xdg.configFile = {
        "niri/config.kdl".text =
          (builtins.readFile ./niri.kdl)
          + "\n"
          + (lib.concatStringsSep "\n" (
            map (m: ''
              // Generated configuration for ${m.output}
              output "${m.output}" {
                  mode "${toString m.width}x${toString m.height}@${toString m.refresh}"
                  scale ${toString m.scale}
                  ${lib.optionalString (m.rotate != 0) ''transform "${toString m.rotate}"''}
                  position x=${toString m.x} y=${toString m.y}
                  ${vrr-parse m.vrr}
                  backdrop-color "#71a5e2"
              }
            '') actualMonitors
          ));

        "swaylock/config".source = ../swaylock/swaylock.conf;
      };
    };
  }
)
