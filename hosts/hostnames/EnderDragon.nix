_: {
  imports = [
    ../../apps/games
    ../../apps/games/minecraft
    ../../apps/llm
    ../../apps/multimedia
    ../../apps/multimedia/audio
    ../../apps/multimedia/audio/extra.nix
    ../../apps/multimedia/video.nix
  ];

  config.hostSettings = {
    display = {
      adapter = {
        enable = true;
        manufacturer = "amd";
      };
      multiMonitor = false;
      hdr = true;
    };
    hardware = {
      enableBluetooth = true;
      enableNfs = true;
      enableRollingKernel = true;
    };
  };
}
