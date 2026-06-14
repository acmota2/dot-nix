{
  samsung = {
    output = "DP-1";
    width = 5120;
    height = 2160;
    refresh = 180;
    x = 0;
    y = 0;
    scale = 1;
    vrr = 2;
    rotate = 0;
    hyprlandExtras = [
      "bitdepth"
      "10"
      # "cm"
      # "hdr"
      # "sdrbrightness"
      # "2"
      # "sdrsaturation"
      # "1.25"
    ];
  };

  portable = {
    output = "DP-3";
    width = 1920;
    height = 1080;
    refresh = 60;
    x = -813;
    y = 0;
    scale = 1.33;
    vrr = 0;
    rotate = 1;
  };

  t480 = {
    output = "eDP-1";
    width = 2560;
    height = 1440;
    refresh = 60;
    x = 0;
    y = 0;
    scale = 1.25;
    vrr = 0;
    rotate = 0;
  };

  tv = {
    output = "HDMI-1";
    width = 1920;
    height = 1080;
    refresh = 60;
    x = 0;
    y = 0;
    scale = 1;
    vrr = 0;
    rotate = 0;
  };
}
