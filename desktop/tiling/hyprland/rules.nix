{
  wayland.windowManager.hyprland.settings.windowrule = [
    "opacity 1 0.9, match:class ^($terminalWindow)$"
    "animation slide down, match:title ^($terminalWindow)$"
    "stay_focused on, match:title ^()$, match:class ^(steam)$"
    "float on, match:class ^(xdg-desktop-portal-gtk)$"
  ];
}
