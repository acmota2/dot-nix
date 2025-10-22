_: {
  services = {
    xserver.enable = true;
    displayManager = {
      enable = true;
      ly = {
        enable = true;
        x11Support = false;
      };
    };
  };
}
