{
  config,
  isHomeManager,
  lib,
  meta,
  pkgs,
  ...
}:
{
  imports = [
    ./gamescope
    ./tiling
  ];

  config = lib.mkIf config.hostSettings.display.adapter.enable (
    lib.mkMerge [
      {
        fonts = {
          fontDir.enable = true;
          fontconfig = {
            enable = true;
            defaultFonts = {
              monospace = [ "JetBrainsMono Nerd Font" ];
              sansSerif = [ "Noto Sans" ];
            };
          };
          packages = with pkgs; [
            font-awesome
            jetbrains-mono
            nerd-fonts.jetbrains-mono
            noto-fonts
            noto-fonts-color-emoji
          ];
        };
        programs = {
          chromium.enable = true;
          dconf.enable = true;
          ydotool.enable = true;
        };

        environment.systemPackages = [
          pkgs.brave
        ];
      }
      (meta.utils.homeOrNixos {
        inherit config isHomeManager;
        options = {
          programs.brave = {
            enable = true;
            commandLineArgs = [
              "--force-device-scale-factor=1.2"
              "--ozone-platform-hint=auto"
            ];
          };
        };
      })
    ]
  );
}
