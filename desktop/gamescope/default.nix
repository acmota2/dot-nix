{ pkgs, ... }:
let
  login = pkgs.writeShellScript "login" ''
    set -euo pipefail

    exec ${pkgs.gamescope}/bin/gamescope \
      --rt \
      --steam -- \
      ${pkgs.steam}/bin/steam \
      -gamepadui
  '';
in
{
  programs = {
    gamescope = {
      enable = true;
      capSysNice = true;
    };
    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
  };

  environment.loginShellInit = ''
    if [ -z "''${DISPLAY:-}" ] && [ "$(tty)" = "/dev/tty1" ]; then
      exec ${login}
    fi
  '';
}
