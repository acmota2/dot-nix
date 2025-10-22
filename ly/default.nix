_: {
  services = {
    xserver.enable = true;
    displayManager = {
      enable = true;
      ly = {
        enable = true;
        settings = {
          animate = true;
          animation = "doom";
          auth_fails = 5;
          bigclock = "english";
          clock = "%c";
          hide_borders = true;
        };
        x11Support = false;
      };
    };
  };
}
