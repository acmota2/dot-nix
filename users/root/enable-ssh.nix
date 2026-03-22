_: {
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB1Bu1KY2x3DGuvOGFhDh00BrXXddgatGno21uEtpOLu acmota2@EnderDragon"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJhL+Z4YaPU5hDtjjsl9HlKCUPekgGKMI3acWEGfffrp acmota2@Allay"
  ];

  services.openssh = {
    settings = {
      AllowUsers = [
        "root"
      ];
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "prohibit-password";
    };
  };
}
