{ pkgs, desktop, ... }:
{
  imports =
    let
      desktopImport = [
        ./${desktop}
        ./foot
        ./walker
        ./wofi
      ];
    in
    if desktop != "hyprland" then desktopImport else desktopImport ++ [ ./tiling/mako ];

  programs.chromium = {
    enable = true;
    extensions = [
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
    ];
  };

  environment.systemPackages = [
    pkgs.discord
    pkgs.spotify
    pkgs.brave
  ];
}
