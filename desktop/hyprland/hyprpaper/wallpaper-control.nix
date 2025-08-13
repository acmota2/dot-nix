{
  pkgs,
  hyprland,
  username,
  ...
}:
let
  hypr = hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
in
{
  # based on https://itsfoss.com/hyprpaper-hyprland/
  systemd.timers."wallpaper-control" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnUnitActiveSec = "1m";
      OnBootSec = "5m";
      OnCalendar = [
        "*-*-* 7:00:00"
        "*-*-* 19:00:00"
      ];
      Unit = "wallpaper-control.service";
    };
  };

  systemd.services."wallpaper-control" = {
    script = ''
      !/bin/sh

      TIME=$(date +%H)

      if [ $TIME -ge 7 ] && [ $TIME -lt 19 ]; then
        WLP=$(ls ~/pictures | grep hot | shuf -n 1)
      else 
        WLP=$(ls ~/pictures | grep cold | shuf -n 1)
      fi

      ${hypr}/bin/hyprctl hyprpaper preload $WLP
      ${hypr}/bin/hyprctl hyprpaper wallpaper $WLP
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "${username}";
    };
  };
}
