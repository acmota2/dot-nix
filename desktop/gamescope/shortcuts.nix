{ pkgs, username, ... }:
let
  steam-youtube = pkgs.writeShellScriptBin "steam-youtube" ''
    exec ${pkgs.glib}/bin/gtk-launch youtube-tv
  '';

  steam-netflix = pkgs.writeShellScriptBin "steam-netflix" ''
    exec ${pkgs.glib}/bin/gtk-launch netflix
  '';

  steam-disney = pkgs.writeShellScriptBin "steam-disney" ''
    exec ${pkgs.glib}/bin/gtk-launch disney-plus
  '';

  firefox = "${pkgs.firefox}/bin/firefox";
  youtubeUserAgent =
    "Mozilla/5.0 (SMART-TV; Linux; Tizen 6.0) "
    + "AppleWebKit/537.36 (KHTML, like Gecko) "
    + "SamsungBrowser/3.0 TV Safari/537.36";
in
{
  environment.systemPackages = [
    pkgs.firefox
    steam-youtube
    steam-netflix
    steam-disney
  ];

  home-manager.users.${username} = {
    xdg.desktopEntries = {
      youtube-tv = {
        name = "YouTube (TV)";
        type = "Application";
        terminal = false;
        startupNotify = false;
        exec = "${firefox} " + ''--user-agent "${youtubeUserAgent}" '' + "https://www.youtube.com/tv";
        categories = [ "AudioVideo" ];
      };

      netflix = {
        name = "Netflix";
        type = "Application";
        terminal = false;
        startupNotify = false;
        exec = "${firefox} " + "https://www.netflix.com";
        categories = [ "AudioVideo" ];
      };

      disney-plus = {
        name = "Disney+";
        type = "Application";
        terminal = false;
        startupNotify = false;
        exec = "${firefox} " + "https://www.disneyplus.com";
        categories = [ "AudioVideo" ];
      };
    };
  };
}
