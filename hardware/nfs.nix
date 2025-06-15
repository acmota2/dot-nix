{
  fileSystems."/mnt/data" = {
    device = "nfs.voldemota.xyz:/general";
    fsType = "nfs";
    options = [
      "noauto"
      "nfsvers=4.2"
      "sync"
      "x-systemd.idle-timeout=600"
      "x-systemd.automount"
    ];
  };
}
