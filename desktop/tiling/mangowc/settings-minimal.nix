{ monitors, renderMonitor }:
{
  # Basic appearance
  allow_tearing = 0;

  # Input
  xkb_rules_layout = "us";
  xkb_rules_variant = "intl";
  repeat_rate = 25;
  repeat_delay = 300;
  trackpad_natural_scrolling = 0;

  # Monitors
  monitorrule = map renderMonitor monitors;

  # Focus rules
  windowrule = [
    "isfloating:1,appid:firefox"
    "isfullscreen:1,appid:firefox"
  ];

  # Startup
  "exec-once" = [
    "foot --server"
    "steam -gamepadui"
  ];

  # Keybinds
  bind = [
    "SUPER,Return,spawn,footclient"
    "SUPER,D,spawn,wofi -S drun,run"
    "SUPER,F,togglefullscreen"
    "SUPER,A,togglefloating"
    "SUPER+SHIFT,Q,killclient"
    "SUPER+SHIFT,C,quit"
    # Focus
    "SUPER,left,focusdir,left"
    "SUPER,right,focusdir,right"
    "SUPER,up,focusdir,up"
    "SUPER,down,focusdir,down"
    # Audio (using wpctl for minimal)
    "NONE,XF86AudioRaiseVolume,spawn,wpctl set-volume @DEFAULT_SINK@ 2%+"
    "NONE,XF86AudioLowerVolume,spawn,wpctl set-volume @DEFAULT_SINK@ 2%-"
    "NONE,XF86AudioMute,spawn,wpctl set-mute @DEFAULT_SINK@ toggle"
    "SHIFT,XF86AudioMute,spawn,wpctl set-mute @DEFAULT_SOURCE@ toggle"
  ];
}
