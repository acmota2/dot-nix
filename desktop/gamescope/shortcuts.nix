{ pkgs, ... }:
let
  steam-brave = pkgs.writeShellScriptBin "steam-brave" ''
    export DBUS_SESSION_BUS_ADDRESS="unix:path=$XDG_RUNTIME_DIR/bus"
    export HOME="/home/$(whoami)"
    export WAYLAND_DISPLAY=$GAMESCOPE_WAYLAND_DISPLAY
    export XDG_RUNTIME_DIR="/run/user/$(id -u)"

    exec ${pkgs.brave}/bin/brave \
      --ozone-platform=wayland \
      --enable-features=UseOzonePlatform \
      --no-sandbox
  '';

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
    pkgs.kitty
    steam-brave
    steamBraveDesktop
  ];
}
