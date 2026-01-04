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
      "i915.enable_psr=1"
      "i915.enable_dc=2"
      "fastboot=1"
    ];
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };
}
