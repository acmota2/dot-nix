{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./gamescope
    ./tiling
  ];

  config = lib.mkIf config.hostSettings.display.adapter.enable {
    programs = {
      chromium.enable = true;
      dconf.enable = true;
      ydotool.enable = true;
    };

    fonts.packages = [
      pkgs.font-awesome
      pkgs.jetbrains-mono
      pkgs.nerd-fonts.jetbrains-mono
      pkgs.noto-fonts
      pkgs.noto-fonts-color-emoji
    ];

    environment.systemPackages = [
      pkgs.brave
    ];
  };
}
