{ username, ... }:
{
  home-manager.users.${username} = _: {
    programs.foot = {
      enable = true;
      settings = {
        main = {
          dpi-aware = "no";
          font = "JetBrainsMono:size=11";
          font-size-adjustment = "1px";
        };
        cursor = {
          style = "beam";
          blink = "yes";
          beam-thickness = 0.4;
        };
        url = {
          launch = "xdg-open $\{url\}";
          osc8-underline = "always";
        };
        colors.background = "0a0117";
      };
    };
  };
}
