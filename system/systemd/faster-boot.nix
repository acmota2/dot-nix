_: {
  services.fwupd.enable = false;

  systemd = {
    oomd.enable = false;

    services.NetworkManager-wait-online.enable = false;
    services.systemd-networkd-wait-online.enable = false;
  };
}
