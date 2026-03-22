{ pkgs, unstable, ... }:
let
  es-de = pkgs.appimageTools.wrapType2 {
    pname = "es-de";
    version = "custom";

    src = pkgs.fetchurl {
      url = "https://gitlab.com/es-de/emulationstation-de/-/package_files/246876039/download";
      hash = "sha256-/RaIA4KO3QaDPlxboj36Nmujvs58BUMpVU+8Qj5+lws=";
    };
  };

  steam-es-de = pkgs.writeShellScriptBin "steam-es-de" ''
    exec ${es-de}/bin/es-de
  '';
in
{
  programs.nix-ld.enable = true;
  services.flatpak.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };

  environment.systemPackages =
    with pkgs;
    [
      dolphin-emu
      flycast
      mame
      mednafen
      pcsx2
      ppsspp-sdl-wayland
      retroarch-free
      steam-es-de
      xemu
      xenia-canary
    ]
    ++ [
      unstable.rpcs3
    ];
}
