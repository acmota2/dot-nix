{ config, lib, ... }:
lib.mkIf config.hostSettings.hardware.enableBluetooth {
  hardware.bluetooth = {
    enable = true;
    settings.General = {
      Experimental = false;
      ControllerMode = "bredr";
    };
  };
  services.blueman.enable = true;
  boot.kernelParams = [
    "btusb.enable_autosuspend=0"
  ];
}
