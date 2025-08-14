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
  systemd.user = {
    timers.wallpaper-control = {
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnUnitActiveSec = "1m";
        OnBootSec = "5m";
        OnCalendar = [
          "*-*-* 7:00:00"
          "*-*-* 19:00:00"
          "*-*-* *:10:00"
        ];
        Persistent = true;
        Unit = "wallpaper-control.service";
      };
    };

    services.wallpaper-control = {
      path = [
        hypr
      ];
      script = ''
        TIME=$(date +%H)

        if [ $TIME -ge 7 ] && [ $TIME -lt 19 ]; then
          WLP=$(ls ~/pictures | grep hot | shuf -n 1)
        else 
          WLP=$(ls ~/pictures | grep cold | shuf -n 1)
        fi

        hyprctl --instance 0 dispatch exec hyprctl hyprpaper preload "/home/${username}/pictures/$WLP"
        hyprctl --instance 0 dispatch exec ${hypr}/bin/hyprctl hyprpaper wallpaper ",/home/${username}/pictures/$WLP"
      '';
      serviceConfig = {
        Type = "oneshot";
        ProtectSystem = "full";
        ProtectHome = true;
        NoNewPriviliges = true;
      };
    };
  };
}
