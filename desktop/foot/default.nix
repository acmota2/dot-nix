{ username, ... }:
{
  home-manager.users.${username} = _: {
    programs.foot = {
      enable = true;
      settings = {
        main = {
          dpi-aware = "yes";
          font = "JetBrainsMono:size=12";
          font-size-adjustment = "1px";
        };
        cursor = {
          style = "beam";
          blink = "yes";
          beam-thickness = 0.5;
        };
        url = {
          launch = "xdg-open $\{url\}";
          osc8-underline = "always";
        };
        colors = {
          foreground = "c0caf5";
          background = "1a1b26";
          regular0 = "15161E"; # black
          regular1 = "f7768e"; # red
          regular2 = "9ece6a"; # green
          regular3 = "e0af68"; # yellow
          regular4 = "7aa2f7"; # blue
          regular5 = "bb9af7"; # magenta
          regular6 = "7dcfff"; # cyan
          regular7 = "a9b1d6"; # white
          bright0 = "414868"; # bright black
          bright1 = "f7768e"; # bright red
          bright2 = "9ece6a"; # bright green
          bright3 = "e0af68"; # bright yellow
          bright4 = "7aa2f7"; # bright blue
          bright5 = "bb9af7"; # bright magenta
          bright6 = "7dcfff"; # bright cyan
          bright7 = "c0caf5"; # bright white
          dim0 = "ff9e64";
          dim1 = "db4b4b";
        };
      };
    };
  };
}
