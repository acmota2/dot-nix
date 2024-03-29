# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
    imports =
        [ (modulesPath + "/installer/scan/not-detected.nix")
        ];

    boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-intel" ];
    boot.extraModulePackages = [ ];

    fileSystems."/" =
    { device = "/dev/disk/by-uuid/a4d3c80a-df15-4cc6-a72f-c1a3c0682511";
        fsType = "ext4";
    };

    fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/2407-ED8B";
        fsType = "vfat";
    };

    swapDevices =
        [ { device = "/dev/disk/by-uuid/13eab05f-c21d-45d5-b740-6cc8bbf30827"; }
        ];

# Enables DHCP on each ethernet and wireless interface. In case of scripted networking
# (the default) this is the recommended approach. When using systemd-networkd it's
# still possible to use this option, but it's recommended to use it in conjunction
# with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
    networking.useDHCP = lib.mkDefault true;
# networking.interfaces.enp3s0.useDHCP = lib.mkDefault true;
# networking.interfaces.wlp2s0.useDHCP = lib.mkDefault true;

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

    environment.sessionVariables = { 
        WLR_DRM_DEVICES = "/dev/dri/card0:/dev/dri/card1";
    };
}
