{ pkgs, ... }:
let
  steam-es-de = pkgs.writeShellScriptBin "steam-es-de" ''
    export XDG_RUNTIME_DIR="/run/user/$(id -u)"
    exec /run/current-system/sw/bin/es-de
  '';

  steam-brave = pkgs.writeShellScriptBin "steam-brave" ''
    export XDG_RUNTIME_DIR="/run/user/$(id -u)"
    export DBUS_SESSION_BUS_ADDRESS="unix:path=$XDG_RUNTIME_DIR/bus"

    exec ${pkgs.brave}/bin/brave \
      --ozone-platform=wayland \
      --enable-features=UseOzonePlatform \
      --no-sandbox
  '';

  steamEsDeDesktop = pkgs.makeDesktopItem {
    name = "steam-es-de";
    desktopName = "EmulationStation DE";
    exec = "${steam-es-de}/bin/steam-es-de";
    terminal = false;
    categories = [
      "Game"
      "Emulator"
    ];
  };

  steamBraveDesktop = pkgs.makeDesktopItem {
    name = "steam-brave";
    desktopName = "Brave";
    exec = "${steam-brave}/bin/steam-brave";
    terminal = false;
    categories = [
      "Network"
      "WebBrowser"
    ];
  };
in
{
  environment.systemPackages = [
    steam-es-de
    steam-brave
    steamEsDeDesktop
    steamBraveDesktop
  ];
}
