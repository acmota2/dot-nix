_: {
  imports = [
    ../../apps/games
    ../../apps/games/minecraft
    ../../apps/multimedia
    ../../apps/multimedia/audio
  ];

  config.hostSettings = {
    display = {
      adapter = {
        enable = true;
        manufacturer = "intel";
      };
      desktop.name = "mangowc";
    };
    hardware = {
      enableBluetooth = true;
      enableNfs = true;
      enableRollingKernel = true;
      isLaptop = true;
    };
  };
}
