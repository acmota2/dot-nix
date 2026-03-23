{ desktop, pkgs, ... }:
let
  tiling = [
    "hyprland"
    "mangowc"
  ];
in
{
  imports =
    if builtins.elem desktop tiling then
      [
        ./tiling
      ]
    else
      [
        ./${desktop}
      ];
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
}
