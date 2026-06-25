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
      desktop = {
        enable = true;
        name = "mangowc";
      };
    };
    hardware = {
      enableBluetooth = true;
      enableNfs = true;
      enableRollingKernel = true;
      isLaptop = true;
      resumeDeviceUuid = "aafebdf9-2bb2-4e78-b367-3436034807a4";
    };
  };
}
