{ config, lib, ... }:
let
  resumeDeviceUuid = config.hostSettings.hardware.resumeDeviceUuid;
in
{
  imports = [ ./kernel-mod ];

  config = lib.mkIf (!config.hostSettings.meta.isWsl) {
    boot = {
      loader = {
        efi.canTouchEfiVariables = true;
        grub = {
          enable = true;
          efiSupport = true;
          device = "nodev";
        };
      };
      plymouth = {
        enable = true;
        theme = "bgrt";
      };
      resumeDevice = lib.mkIf (resumeDeviceUuid != "") "/dev/disk/by-uuid/${resumeDeviceUuid}";
    };
  };
}
