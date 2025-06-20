{
  listener = [
    {
      timeout = 300; # 5min
      on-timeout = "hyprctl dispatch dpms off"; # screen off when timeout has passed
      on-resume = "hyprctl dispatch dpms on && brightnessctl -r"; # screen on when activity is detected after timeout has fired.
    }
    {
      timeout = 1800; # 30min
      on-timeout = "systemctl suspend"; # suspend pc
    }
  ];
}
