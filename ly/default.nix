_: {
  programs.hyprland.enable = true;
  services = {
    xserver.enable = true;
    x11Support = false;
    displayManager = {
      enable = true;
      ly = {
        enable = true;
        settings = {
          animate = true;
          animation = "doom";
          auth_fails = 5;
          bigclock = "english";
        };
      };
    };
  };
}
