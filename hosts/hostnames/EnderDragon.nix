_: {
  imports = [
    ../../apps/games
    ../../apps/games/minecraft
    ../../apps/llm
    ../../apps/misc/rgb.nix
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
      hdr = true;
      desktop = {
        enable = true;
        name = "niri";
        noctalia.enable = true;
      };
    };
    hardware = {
      enableBluetooth = true;
      enableNfs = true;
      enableRollingKernel = true;
      resumeDeviceUuid = "4d4efbda-9f85-42a0-adf0-4c60d9f6d6e6";
    };
  };
}
