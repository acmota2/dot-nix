{
  config,
  pkgs,
  unstable,
  ...
}:

let
  retroarchPkg = pkgs.retroarch-free.withCores (
    cores: with cores; [
      beetle-psx-hw
      beetle-saturn
      gambatte
      genesis-plus-gx
    ]
  );

  retroarchBin = "${retroarchPkg}/bin/retroarch";

  es-de = pkgs.appimageTools.wrapType2 {
    pname = "es-de";
    version = "custom";

    src = pkgs.fetchurl {
      url = "https://gitlab.com/es-de/emulationstation-de/-/package_files/246876039/download";
      hash = "sha256-/RaIA4KO3QaDPlxboj36Nmujvs58BUMpVU+8Qj5+lws=";
    };

    extraPkgs =
      pkgs: with pkgs; [
        gtk3
        glib
        gsettings-desktop-schemas
        shared-mime-info
        desktop-file-utils
        hicolor-icon-theme
        adwaita-icon-theme
      ];
  };

  steam-es-de = pkgs.writeShellScriptBin "steam-es-de" ''
    export RETROARCH_PATH="${retroarchBin}"
    export LIBRETRO_DIRECTORY="/var/lib/retrocompat/cores"
    export LIBRETRO_INFO_PATH="/var/lib/retrocompat/info"
    export RETROARCH_ASSETS_DIRECTORY="${retroarchPkg}/share/retroarch/assets"
    export RETROARCH_DATABASE_DIRECTORY="${retroarchPkg}/share/retroarch/database"
    export RETROARCH_AUTOCONFIG_DIRECTORY="${retroarchPkg}/share/retroarch/autoconfig"
    export RETROARCH_SHADER_DIRECTORY="${retroarchPkg}/share/retroarch/shaders"

    export XDG_DATA_DIRS="${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}:${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}:$XDG_DATA_DIRS"

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

  steam-retroarch = pkgs.writeShellScriptBin "steam-retroarch" ''
    exec ${retroarchBin} \
      --fullscreen \
      --menu \
      --verbose \
      --set-shader-watch-files \
      --appendconfig /dev/null
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
      steam-es-de
      steam-es-de-desktop
      steam-retroarch

      retroarchPkg

      dolphin-emu
      flycast
      mame
      mgba
      pcsx2
      ppsspp-sdl-wayland
      snes9x
      xemu
      xenia-canary
    ]
    ++ [
      unstable.rpcs3
    ];

  system.activationScripts.retrocompat.text = ''
    mkdir -p /var/lib/retrocompat/cores
    mkdir -p /var/lib/retrocompat/info

    rm -f /var/lib/retrocompat/cores/*
    rm -f /var/lib/retrocompat/info/*

    find ${retroarchPkg} -type f -name "*_libretro.so" -exec ln -sf {} /var/lib/retrocompat/cores/ \;
    find ${retroarchPkg} -type f -name "*.info" -exec ln -sf {} /var/lib/retrocompat/info/ \;
  '';

  home-manager.users.${config.users.default.username}.xdg.desktopEntries = {
    retroarch = {
      name = "RetroArch";
      comment = "Multi-system emulator frontend";
      exec = "${steam-retroarch}/bin/steam-retroarch";
      terminal = false;
      categories = [
        "Game"
        "Emulator"
      ];
    };

    emulationstation = {
      name = "EmulationStation DE";
      comment = "Console-style frontend";
      exec = "${steam-es-de}/bin/steam-es-de";
      terminal = false;
      categories = [
        "Game"
        "Emulator"
      ];
    };
  };
}
