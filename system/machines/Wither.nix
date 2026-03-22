_: {
  fileSystems."/games" = {
    device = "/dev/disk/by-uuid/89391e3b-0c9e-4cbc-bafc-80a2275c435b";
    fsType = "btrfs";
    options = [
      "rw"
      "nofail"
      "compress=zstd"
      "ssd"
    ];
  };
}
