{
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
    resumeDevice = "/dev/disk/by-uuid/4d4efbda-9f85-42a0-adf0-4c60d9f6d6e6";
  };
}
