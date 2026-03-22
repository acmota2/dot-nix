{ pkgs, username, ... }:
let
  steamBigPicture = pkgs.writeShellScript "steam-big-picture" ''
    set -euo pipefail
    export XDG_RUNTIME_DIR="/run/user/$(id -u)"

    exec ${pkgs.gamescope}/bin/gamescope \
      --rt \
      --steam \
      -- \
      ${pkgs.steam}/bin/steam \
      -gamepadui
  '';

  steamDesktop = pkgs.writeShellScript "steam-desktop" ''
    set -euo pipefail
    export XDG_RUNTIME_DIR="/run/user/$(id -u)"

    exec ${pkgs.gamescope}/bin/gamescope \
      --rt \
      -- \
      ${pkgs.steam}/bin/steam
  '';
in
{
  imports = [ ./shortcuts.nix ];

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

  users.users.${username}.extraGroups = [
    "input"
    "render"
    "video"
  ];

  environment.loginShellInit = ''
    if [ -z "''${DISPLAY:-}" ]; then
      case "$(tty)" in
        /dev/tty1)
          exec ${steamBigPicture}
          ;;
        /dev/tty2)
          exec ${steamDesktop}
          ;;
      esac
    fi
  '';
}
