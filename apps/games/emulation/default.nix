{
  pkgs,
  unstable,
  username,
  ...
}:
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

  steam-es-de-desktop = pkgs.makeDesktopItem {
    name = "steam-es-de";
    desktopName = "EmulationStation DE";
    exec = "${steam-es-de}/bin/steam-es-de";
    terminal = false;
    categories = [
      "Game"
      "Emulator"
    ];
  };

  retroarch = "${pkgs.retroarch-free}/bin/retroarch";
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
      libretro.beetle-psx-hw
      libretro.beetle-saturn
      libretro.gambatte
      libretro.genesis-plus-gx
      mame
      mgba
      pcsx2
      ppsspp-sdl-wayland
      retroarch-free
      snes9x
      steam-es-de
      steam-es-de-desktop
      xemu
      xenia-canary
    ]
    ++ [
      unstable.rpcs3
    ];

  home-manager.users.${username} = {
    xdg.desktopEntries = {
      retroarch = {
        name = "RetroArch";
        comment = "Multi-system emulator frontend";
        exec = "${pkgs.util-linux}/bin/setsid -f ${retroarch} " + "--fullscreen " + "--menu" + "--verbose";
        terminal = false;
        categories = [
          "Game"
          "Emulator"
        ];
      };
    };
  };
}
