_: {
  config.hostSettings = {
    adapter = {
      enable = true;
      manufacturer = "intel";
    };
    desktop = "mangowc";
    hardware = {
      enableBluetooth = true;
      enableRollingKernel = true;
      isLaptop = true;
    };
  };
  modules = [
    ./apps/games
    ./apps/games/minecraft
    ./apps/multimedia
    ./apps/multimedia/audio
  ];
}
