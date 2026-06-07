{ actualMonitors, renderMonitor }:
{
  # General appearance
  bordercolor = "0x333333aa";
  borderpx = 2;
  default_mfact = 0.5;
  default_nmaster = 1;
  focuscolor = "0x007184ee";
  gappih = 3;
  gappiv = 3;
  gappoh = 10;
  gappov = 3;
  new_is_master = 0;
  rootcolor = "0x007184ee";
  smartgaps = 0;
  urgentcolor = "0xad401fff";

  # Monitors
  monitorrule = map renderMonitor actualMonitors;

  # Animations
  animations = 1;
  layer_animations = 0;
  animation_type_open = "slide";
  animation_type_close = "slide";
  animation_duration_open = 120;
  animation_duration_close = 120;
  animation_duration_move = 0;
  animation_duration_focus = 0;
  animation_duration_tag = 180;
  animation_curve_tag = "0.46,1.0,0.29,0.99";

  # Tearing & Input
  allow_tearing = 0;
  xkb_rules_layout = "us";
  xkb_rules_variant = "intl";
  repeat_rate = 25;
  repeat_delay = 300;
  trackpad_natural_scrolling = 0;

  # Window rules
  windowrule = [
    "isfloating:1,appid:xdg-desktop-portal-gtk"
    "focused_opacity:0.9,unfocused_opacity:0.8,appid:footclient"
  ];

  # Startup
  exec-once = [
    "blueman-applet"
    "elephant"
    "foot --server"
    "mako"
    "sway-audio-idle-inhibit"
    "swayosd-server"
    "walker --gapplication-service"
    "waybar"
    "wl-paste --type image --watch cliphist store"
    "wl-paste --type text --watch cliphist store"
  ];

  # Keybinds
  bind = [
    # Layouts
    "SUPER,F1,setlayout,tile"
    "SUPER,F2,setlayout,scroller"
    "SUPER,F3,setlayout,monocle"
    "SUPER,F4,setlayout,grid"
    "SUPER,F5,switch_layout"

    # Moving windows
    "SUPER+CTRL,left,focusmon,left"
    "SUPER+CTRL,right,focusmon,right"
    "SUPER+CTRL+SHIFT,left,tagmon,left,1"
    "SUPER+CTRL+SHIFT,right,tagmon,right,1"

    # Programs
    "SUPER,Return,spawn,footclient -e tmux"
    "SUPER,D,spawn,walker"
    # "SUPER+SHIFT,D,spawn,walker" # Removed
    "SUPER,V,spawn,walker --provider clipboard"
    "SUPER,E,spawn,walker --provider symbols"
    "SUPER,P,spawn,walker-power-menu"

    # Printscreen
    "NONE,Print,spawn_shell,grim - | wl-copy"
    "SUPER,Print,spawn_shell,grim -g \"$(slurp)\" - | wl-copy" # TODO: review
    "SUPER+SHIFT,Print,spawn_shell,grim -g \"$(slurp)\" - | wl-copy"

    # Windows
    "SUPER,left,focusdir,left"
    "SUPER,right,focusdir,right"
    "SUPER,up,focusdir,up"
    "SUPER,down,focusdir,down"
    "SUPER+SHIFT,left,exchange_client,left"
    "SUPER+SHIFT,right,exchange_client,right"
    "SUPER+SHIFT,up,exchange_client,up"
    "SUPER+SHIFT,down,exchange_client,down"
    "ALT+SHIFT,right,resizewin,+25,0"
    "ALT+SHIFT,up,resizewin,0,-25"
    "ALT+SHIFT,down,resizewin,0,+25"
    "ALT+SHIFT,left,resizewin,-25,0"
    "SUPER,F,togglefullscreen"
    "SUPER,A,togglefloating"
    "SUPER,1,view,1"
    "SUPER,2,view,2"
    "SUPER,3,view,3"
    "SUPER,4,view,4"
    "SUPER,5,view,5"
    "SUPER,6,view,6"
    "SUPER,7,view,7"
    "SUPER,8,view,8"
    "SUPER,9,view,9"
    "SUPER+SHIFT,1,tag,1"
    "SUPER+SHIFT,2,tag,2"
    "SUPER+SHIFT,3,tag,3"
    "SUPER+SHIFT,4,tag,4"
    "SUPER+SHIFT,5,tag,5"
    "SUPER+SHIFT,6,tag,6"
    "SUPER+SHIFT,7,tag,7"
    "SUPER+SHIFT,8,tag,8"
    "SUPER+SHIFT,9,tag,9"

    # Special
    "NONE,XF86MonBrightnessUp,spawn,swayosd-client --brightness raise"
    "SHIFT,XF86MonBrightnessUp,spawn,swayosd-client --brightness +100"
    "NONE,XF86MonBrightnessDown,spawn,swayosd-client --brightness lower"
    "SHIFT,XF86MonBrightnessDown,spawn,swayosd-client --brightness 1"
    "NONE,XF86AudioRaiseVolume,spawn,swayosd-client --output-volume raise"
    "NONE,XF86AudioLowerVolume,spawn,swayosd-client --output-volume lower"
    "NONE,XF86AudioMute,spawn,swayosd-client --output-volume mute-toggle"
    "SHIFT,XF86AudioMute,spawn,swayosd-client --input-volume mute-toggle"

    # Compositor
    "SUPER+SHIFT,C,quit"
    "SUPER+SHIFT,Q,killclient"
    "SUPER,r,reload_config"
  ];

  bindl = [ "SUPER,L,spawn,swaylock" ];
  axisbind = [
    "SUPER,UP,viewtoleft_have_client"
    "SUPER,DOWN,viewtoright_have_client"
  ];
  mousebind = [
    "SUPER,btn_left,moveresize,curmove"
    "SUPER,btn_right,moveresize,curresize"
  ];
}
