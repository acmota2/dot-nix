{ monitors, ... }:
let
  renderMonitor =
    m:
    builtins.concatStringsSep "," [
      m.output
      "${toString m.width}x${toString m.height}@${toString m.refresh}"
      "${toString m.x}x${toString m.y}"
      (toString m.scale)
      "vrr"
      (toString m.vrr)
      "transform"
      (toString m.rotate)
    ];

  renderedMonitors = map renderMonitor monitors;
in
{
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    "$terminal" = "footclient";
    "$terminalWindow" = "footclient";
    "$menu" = "wofi -S drun,run";

    monitor = renderedMonitors;

    exec-once = [
      "foot --server"
      "tmux"
      "waybar"
      "mako"
      "hyprpaper"
      "blueman-applet"
      "wl-paste --type text --watch cliphist store"
      "wl-paste --type image --watch cliphist store"
    ];

    cursor.no_hardware_cursors = true;

    ecosystem = {
      no_update_news = true;
      no_donation_nag = true;
    };

    input = {
      kb_layout = "us,us";
      kb_variant = "intl,";
      kb_options = "lv3:menu_switch";
      follow_mouse = 1;
      touchpad.natural_scroll = false;
      sensitivity = 0;
      repeat_delay = 300;
    };

    general = {
      gaps_in = 3;
      gaps_out = 10;
      border_size = 1;
      "col.active_border" = "rgba(007184ee) rgba(008194ee) 60deg";
      "col.inactive_border" = "rgba(333333aa)";
      allow_tearing = false;
    };

    decoration = {
      rounding = 5;
      blur = {
        enabled = true;
        size = 3;
        passes = 1;
      };
    };

    animations = {
      enabled = true;
      bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
      animation = [
        "windows,1, 4, myBezier"
        "windowsOut,1, 4, default, popin 80%"
        "border,1, 10, default"
        "borderangle,1, 8, default"
        "fade,1, 4, default"
        "workspaces,1, 4, default"
      ];
    };

    dwindle = {
      pseudotile = true;
      preserve_split = true;
    };

    misc = {
      force_default_wallpaper = 0;
    };
  };
}
