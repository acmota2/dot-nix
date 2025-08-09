{ monitors, hdr, ... }:
{
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    "$terminal" = "footclient";
    "$terminalWindow" = "footclient";
    "$menu" = "wofi -S drun,run";
    monitor = map (
      settings:
      let
        inherit (settings)
          port
          resolution
          rr
          scale
          extra
          ;
      in
      "${port},${resolution}@${rr}.00,0x0,${scale},${extra}"
    ) monitors;
    # workspace = builtins.genList (i: "${toString i}") 9;

    exec-once = [
      "foot --server"
      "tmux"
      "waybar"
      "mako"
      "hyprpaper"
      "blueman-applet"
      "wl-paste --type text --watch cliphist store" # Stores only text data
      "wl-paste --type image --watch cliphist store" # Stores only image data
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

    gestures.workspace_swipe = 0;

    dwindle = {
      pseudotile = true; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
      preserve_split = true; # you probably want this
    };

    misc = {
      force_default_wallpaper = 0; # Set to 0 to disable the anime mascot wallpapers
    };

    experimental =
      if hdr then
        {
          xx_color_management_v4 = true;
        }
      else
        { };
  };
}
