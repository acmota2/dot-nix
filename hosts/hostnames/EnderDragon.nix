_: {
  config.hostSettings = {
    display = {
      adapter = {
        enable = true;
        manufacturer = "amd";
      };
      desktop = "mangowc";
      hardware = {
        enableBluetooth = true;
        enableRollingKernel = true;
        isLaptop = true;
      };
      multiMonitor = true;
      hdr = true;
    };
  };

  modules = [
    ./apps/games
    ./apps/games/minecraft
    ./apps/llm
    ./apps/multimedia
    ./apps/multimedia/audio
    ./apps/multimedia/audio/extra.nix
    ./apps/multimedia/video.nix
  ];
}
