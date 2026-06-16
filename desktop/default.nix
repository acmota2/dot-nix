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

        environment.systemPackages = with pkgs; [
          brave
          floorp-bin
        ];
      }
      (meta.utils.homeOrNixos {
        inherit config isHomeManager;
        options = {
          programs = {
            brave = {
              enable = true;
              commandLineArgs = [
                "--force-device-scale-factor=1.2"
                "--ozone-platform-hint=auto"
                "--enable-features=WaylandWindowDecorations"
              ];
            };
            floorp = {
              enable = true;
              profiles.default = {
                settings = {
                  # Replaces: "--force-device-scale-factor=1.2"
                  "layout.css.devPixelsPerPx" = "1.2";

                  # Replaces: "--enable-features=WaylandWindowDecorations"
                  # Tells Floorp to use client-side tabs/decorations natively under Wayland
                  "browser.tabs.drawInTitlebar" = true;
                };
              };
            };
          };
          home.sessionVariables = {
            MOZ_ENABLE_WAYLAND = "1";
          };
        };
      })
    ]
  );
}
