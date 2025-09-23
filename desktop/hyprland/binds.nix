{ pkgs, ... }:
let
  workspaceBinds = builtins.concatLists (
    builtins.genList (
      i:
      let
        ws = i + 1;
      in
      [
        "$mod, code:1${toString i}, workspace, ${toString ws}"
        "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
      ]
    ) 9
  );

  wallpaper-choose = pkgs.writeShellScript "wallpaper-spawn" (
    builtins.readFile ./hyprpaper/wallpaper-spawn.sh
  );
in
{
  wayland.windowManager.hyprland.settings = {
    bind = workspaceBinds ++ [
      # main binds
      # exit hyprland - logs off
      "$mod SHIFT, C, exit,"
      # execute shortcuts
      "$mod, return, exec, $terminal"
      "$mod, D, exec, $menu"
      "$mod SHIFT, d, exec, walker"
      "$mod, V, exec, cliphist list | wofi --dmenu | cliphist decode | wl-copy"
      "$mod, E, exec, wofi-emoji"
      "$mod, P, exec, wofi-power-menu"
      "$mod, L, exec, hyprlock"
      "$mod SHIFT, Q, killactive"
      "$mod, W, exec, ${wallpaper-choose}"
      # move between windows
      "$mod, left, movefocus, l"
      "$mod, right, movefocus, r"
      "$mod, up, movefocus, u"
      "$mod, down, movefocus, d"
      # move windows
      "$mod SHIFT, left, movewindow, l"
      "$mod SHIFT, right, movewindow, r"
      "$mod SHIFT, up, movewindow, u"
      "$mod SHIFT, down, movewindow, d"
      # resize windows
      "ALT SHIFT, right, resizeactive, 25 0"
      "ALT SHIFT, up, resizeactive, 0 -25"
      "ALT SHIFT, down, resizeactive, 0 25"
      "ALT SHIFT, left, resizeactive, -25 0"
      # fullscreen window
      "$mod, F, fullscreen, 0"
      "$mod, A, togglefloating,"
      # Example special workspace (scratchpad)
      "$mod, S, togglespecialworkspace, magic"
      "$mod SHIFT, S, movetoworkspace, special:magic"
      # Scroll through existing workspaces with mod + scroll
      "$mod, mouse_down, workspace, e+1"
      "$mod, mouse_up, workspace, e-1"
      # hyprshot
      "$mod, PRINT, exec, hyprshot -m window --clipboard-only"
      ", PRINT, exec, hyprshot -m output --clipboard-only"
      "$mod SHIFT, PRINT, exec, hyprshot -m region --clipboard-only"
    ];
    binde = [
      # bightness keys
      ", XF86MonBrightnessUp, exec, brightnessctl set 5%+"
      ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
      # volume keys
      ", XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +2%"
    ];
    bindl = [
      # more volume keys
      ", XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -2%"
      ", XF86AudioMute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle"
    ];
    bindm = [
      # Move/resize windows with mod + LMB/RMB and dragging"
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];
  };
}
