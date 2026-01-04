{
  hardware.bluetooth = {
    enable = true;
    settings.General = {
      Experimental = true;
      Enable = "Source,Sink,Media,Socket";
    };
  };
  services.blueman.enable = true;
  boot.kernelParams = [
    "btusb.enable_autosuspend=0"
  ];
}
