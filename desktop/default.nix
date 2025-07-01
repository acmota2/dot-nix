{ pkgs, desktop, ... }:
{
  imports =
    let
      desktopImport = [
        ./${desktop}
        ./wofi
        ./foot
      ];
    in
    if desktop != "hyprland" then desktopImport else desktopImport ++ [ ./tiling/mako ];

  programs.firefox = {
    enable = true;
    policies.DisableTelemetry = true;
    policies.Homepage.StartPage = "https://home.voldemota.xyz";
  };

  environment.systemPackages = [
    pkgs.discord
    pkgs.spotify
  ];
}
