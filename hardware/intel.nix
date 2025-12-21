{ pkgs, ... }:
{
  hardware = {
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-vaapi-driver
        intel-media-driver
        libvdpau-va-gl
      ];
    };
  };

  # all my devices are newer than skylake
  boot = {
    initrd.kernelModules = [ "i915" ];
    kernelParams = [
      "i915.enable_guc=3"
      "enable_fbc=1"
      "fastboot=1"
    ];
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };
}
