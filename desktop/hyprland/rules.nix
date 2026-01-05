{
  wayland.windowManager.hyprland.settings.windowrule = [
    "opacity 0.9 0.8, match:class ^($terminalWindow)$"
    "animation slide down, match:title ^($terminalWindow)$"
    "stay_focused on, match:title ^()$, match:class ^(steam)$"
  ];
}
